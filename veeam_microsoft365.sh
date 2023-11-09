#!/bin/bash
##      .SYNOPSIS
##      Grafana Dashboard for Veeam Backup for Microsoft 365 v7.0 - Using RestAPI to InfluxDB Script
## 
##      .DESCRIPTION
##      This Script will query the Veeam Backup for Microsoft 365 RestAPI and send the data directly to InfluxDB, which can be used to present it to Grafana. 
##      The Script and the Grafana Dashboard it is provided as it is, and bear in mind you can not open support Tickets regarding this project. It is a Community Project
##	
##      .Notes
##      NAME:  veeam_microsoft365.sh
##      ORIGINAL veeam_microsoft365.sh
##      LASTEDIT: 02/03/2023
##      VERSION: 7.0
##      KEYWORDS: Veeam, InfluxDB, Grafana
   
##      .Link
##      https://jorgedelacruz.es/
##      https://jorgedelacruz.uk/

##
# Configurations
##
# Endpoint URL for InfluxDB
veeamInfluxDBURL="http://10.12.0.156" #Your InfluxDB Server, http://FQDN or https://FQDN if using SSL
veeamInfluxDBPort="8086" #Default Port
veeamInfluxDBBucket="Veeam" # InfluxDB bucket name (not ID)
veeamInfluxDBToken="hayQLUWMHbY5tDc7imf8wwBkySFUiHhDf3jANT-QwRuShXIJWL1LHh_Xu7Xv0Tn5N7xZl9rcH5inTe3uCurXow==" # InfluxDB access token with read/write privileges for the bucket
veeamInfluxDBOrg="wiz" # InfluxDB organisation name (not ID)

# Endpoint URL for login action
veeamUsername="PARCORRETORA\sis.veeam"
veeamPassword="wrjKprBBnjNqYyyH@**"
veeamRestServer="https://srve067.parcorretora.corp"
veeamRestPort="9443" #Default Port
veeamBearer=$(curl -X POST --header "Content-Type: application/x-www-form-urlencoded" --header "Accept: application/json" -d "grant_type=password&username=$veeamUsername&password=$veeamPassword&refresh_token=%27%27" "$veeamRestServer:$veeamRestPort/v7/token" -k --silent | jq -r '.access_token')


##
# Veeam Backup for Microsoft 365 Version. This part will check the Veeam Backup for Microsoft 365 version
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/ServiceInstance"
veeamVersionUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)
    
    veeamVersion=$(echo "$veeamVersionUrl" | jq --raw-output ".version")
    #echo "veeam_office365_version,veeamVersion=$veeamVersion,veeamServer=$veeamRestServer v=1"
    
    echo "Writing veeam_office365_version to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_version,veeamVersion=$veeamVersion,veeamServer=$veeamRestServer v=1" --skip-verify


##
# Veeam Backup for Microsoft 365 Organization. This part will check on our Organization and retrieve Licensing Information
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/Organizations"
veeamOrgUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

declare -i arrayorg=0
for id in $(echo "$veeamOrgUrl" | jq -r '.[].id'); do
    veeamOrgId=$(echo "$veeamOrgUrl" | jq --raw-output ".[$arrayorg].id")
    veeamOrgName=$(echo "$veeamOrgUrl" | jq --raw-output ".[$arrayorg].name" | awk '{gsub(/ /,"\\ ");print}')

    ## Licensing
    veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/Organizations/$veeamOrgId/LicensingInformation"
    veeamLicenseUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)
    licensedUsers=$(echo "$veeamLicenseUrl" | jq --raw-output '.licensedUsers')
    newUsers=$(echo "$veeamLicenseUrl" | jq --raw-output '.newUsers')
    
    #echo "veeam_office365_organization,veeamOrgName=$veeamOrgName licensedUsers=$licensedUsers,newUsers=$newUsers"
    echo "Writing veeam_office365_organization to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_organization,veeamOrgName=$veeamOrgName licensedUsers=$licensedUsers,newUsers=$newUsers" --skip-verify
    
    ##
    # Veeam Backup for Microsoft 365 Users. This part will check the total Users and if they are protected or not
    ##
    veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/LicensedUsers"
    veeamUsersUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)
    declare -i arrayLicensed=0
    for id in $(echo "$veeamUsersUrl" | jq -r '.results[].id'); do
    veeamUserId=$(echo "$veeamUsersUrl" | jq --raw-output ".results[$arrayLicensed].id")
    veeamUserName=$(echo "$veeamUsersUrl" | jq --raw-output ".results[$arrayLicensed].name" | awk '{gsub(/ /,"\\ ");print}')
    veeamUserBackup=$(echo "$veeamUsersUrl" | jq --raw-output ".results[$arrayLicensed].isBackedUp")   
      case $veeamUserBackup in
        "true")
            protectedUser="1"
        ;;
        "false")
            protectedUser="2"
        ;;
        esac
     veeamLicensedType=$(echo "$veeamUsersUrl" | jq --raw-output ".results[$arrayLicensed].licenseState")   
      case $veeamLicensedType in
        "Licensed")
            LicensedUser="1"
        ;;
        "Unlicensed")
            LicensedUser="2"
        ;;
        esac
    
    #echo "veeam_office365_overview_OD,veeamOrgName=$veeamOrgName,veeamUserName=$veeamUserName protectedUser=$protectedUser,licensedUser=$LicensedUser"
    echo "Writing veeam_office365_overview_OD to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_overview_OD,veeamOrgName=$veeamOrgName,veeamUserName=$veeamUserName protectedUser=$protectedUser,licensedUser=$LicensedUser" --skip-verify
    arrayLicensed=$arrayLicensed+1
    done

    arrayorg=$arrayorg+1
done
 

##
# Veeam Backup for Microsoft 365 Backup Repositories. This part will check the capacity and used space of the Backup Repositories
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/BackupRepositories"
veeamRepoUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

declare -i arrayrepo=0
for id in $(echo "$veeamRepoUrl" | jq -r '.[].id'); do
  repository=$(echo "$veeamRepoUrl" | jq --raw-output ".[$arrayrepo].name" | awk '{gsub(/ /,"\\ ");print}')
  capacity=$(echo "$veeamRepoUrl" | jq --raw-output ".[$arrayrepo].capacityBytes")
  freeSpace=$(echo "$veeamRepoUrl" | jq --raw-output ".[$arrayrepo].freeSpaceBytes")
  objectStorageId=$(echo "$veeamRepoUrl" | jq --raw-output ".[$arrayrepo].objectStorageId")
  objectStorageEncryptionEnabled=$(echo "$veeamRepoUrl" | jq --raw-output ".[$arrayrepo].objectStorageEncryptionEnabled")
  
  #echo "veeam_office365_repository,repository=$repository capacity=$capacity,freeSpace=$freeSpace"
    echo "Writing veeam_office365_repository to InfluxDB"
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_repository,repository=$repository capacity=$capacity,freeSpace=$freeSpace" --skip-verify
  if [[ "$objectStorageId" == "null" ]]; then
        echo "It seems you are not using Object Storage offload on the Repository $repository, that's fine."
  else  
  ##
  # Veeam Backup for Microsoft 365 Object Storage Repositories. This part will check the capacity and used space of the Object Storage Repositories
  ##
  veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/objectstoragerepositories/$objectStorageId"
  veeamObjectUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

        objectName=$(echo "$veeamObjectUrl" | jq --raw-output ".name" | awk '{gsub(/ /,"\\ ");print}')
        usedSpaceGB=$(echo "$veeamObjectUrl" | jq --raw-output ".usedSpaceBytes")
        immutability=$(echo "$veeamObjectUrl" | jq --raw-output ".enableImmutability")
        type=$(echo "$veeamObjectUrl" | jq --raw-output ".type")
        # Bucket information
        case $type in
        "AmazonS3Compatible")
            bucketname=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Compatible.name" | awk '{gsub(/ /,"\\ ");print}')
            servicePoint=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Compatible.servicePoint" | awk '{gsub(/ /,"\\ ");print}')
            customRegionId=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Compatible.customRegionId" | awk '{gsub(/ /,"\\ ");print}')
        ;;
        "AmazonS3")
            bucketname=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Aws.name" | awk '{gsub(/ /,"\\ ");print}')
            servicePoint=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Aws.regionId" | awk '{gsub(/ /,"\\ ");print}')
            customRegionId=$(echo "$veeamObjectUrl" | jq --raw-output ".amazonBucketS3Aws.regionName" | awk '{gsub(/ /,"\\ ");print}')
        ;;
        "AzureBlob")
            bucketname=$(echo "$veeamObjectUrl" | jq --raw-output ".azureContainer.name" | awk '{gsub(/ /,"\\ ");print}')
            servicePoint="AzureBlob"
            customRegionId=$(echo "$veeamObjectUrl" | jq --raw-output ".azureContainer.regionType" | awk '{gsub(/ /,"\\ ");print}')
        ;;
        esac

        #echo "veeam_office365_objectstorage,objectname=$objectName,type=$type,bucketname=$bucketname,servicePoint=$servicePoint,customRegionId=$customRegionId,objectStorageEncryptionEnabled=$objectStorageEncryptionEnabled usedSpaceGB=$usedSpaceGB"
        echo "Writing veeam_office365_objectstorage to InfluxDB" 
        influx write \
        -t "$veeamInfluxDBToken" \
        -b "$veeamInfluxDBBucket" \
        -o "$veeamInfluxDBOrg" \
        -p s \
        "veeam_office365_objectstorage,objectname=$objectName,type=$type,bucketname=$bucketname,servicePoint=$servicePoint,customRegionId=$customRegionId,objectStorageEncryptionEnabled=$objectStorageEncryptionEnabled usedSpaceGB=$usedSpaceGB,immutability=$immutability" --skip-verify
    fi
    arrayrepo=$arrayrepo+1
done


##
# Veeam Backup for Microsoft 365 Backup Proxies. This part will check the Name and Threads Number of the Backup Proxies
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/Proxies?extendedView=true"
veeamProxyUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

declare -i arrayprox=0
for id in $(echo "$veeamProxyUrl" | jq -r '.[].id'); do
    hostName=$(echo "$veeamProxyUrl" | jq --raw-output ".[$arrayprox].hostName" | awk '{gsub(/ /,"\\ ");print}')
    threadsNumber=$(echo "$veeamProxyUrl" | jq --raw-output ".[$arrayprox].threadsNumber")
    status=$(echo "$veeamProxyUrl" | jq --raw-output ".[$arrayprox].status")
    
    #echo "veeam_office365_proxies,proxies=$hostName,status=$status threadsNumber=$threadsNumber"
    echo "Writing veeam_office365_proxies to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_proxies,proxies=$hostName,status=$status threadsNumber=$threadsNumber" --skip-verify
    arrayprox=$arrayprox+1
done

##
# Veeam Backup for Microsoft 365 Backup Jobs. This part will check the different Jobs, and the Job Sessions per every Job
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/Jobs"
veeamJobsUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

declare -i arrayJobs=0
for id in $(echo "$veeamJobsUrl" | jq -r '.[].id'); do
    nameJob=$(echo "$veeamJobsUrl" | jq --raw-output ".[$arrayJobs].name" | awk '{gsub(/ /,"\\ ");print}')
    idJob=$(echo "$veeamJobsUrl" | jq --raw-output ".[$arrayJobs].id")

    # Backup Job Sessions
    veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/JobSessions?jobId=$idJob"
    veeamJobSessionsUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)
    declare -i arrayJobsSessions=0
    for id in $(echo "$veeamJobSessionsUrl" | jq -r '.results[].id'); do
        status=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].status")

        if [[ "$status" != "Running" ]]; then
            creationTime=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].creationTime")
            creationTimeUnix=$(date -d "$creationTime" +"%s")
            endTime=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].endTime")
            endTimeUnix=$(date -d "$endTime" +"%s")
            totalDuration=$(($endTimeUnix - $creationTimeUnix))
      
            case $status in
                Success)
                    jobStatus="1"
                ;;
                Warning)
                    jobStatus="2"
                ;;
                Failed)
                    jobStatus="3"
                ;;
            esac 
            processingRate=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.processingRateBytesPS")
            readRate=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.readRateBytesPS")
            writeRate=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.writeRateBytesPS")
            transferredData=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.transferredDataBytes")
            processedObjects=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.processedObjects")
            bottleneck=$(echo "$veeamJobSessionsUrl" | jq --raw-output ".results[$arrayJobsSessions].statistics.bottleneck")
      
            #echo "veeam_office365_jobs,veeamjobname=$nameJob,bottleneck=$bottleneck totalDuration=$totalDuration,status=$jobStatus,processingRate=$processingRate,readRate=$readRate,writeRate=$writeRate,transferredData=$transferredData,processedObjects=$processedObjects $endTimeUnix"
            echo "Writing veeam_office365_jobs to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_jobs,veeamjobname=$nameJob,bottleneck=$bottleneck totalDuration=$totalDuration,status=$jobStatus,processingRate=$processingRate,readRate=$readRate,writeRate=$writeRate,transferredData=$transferredData,processedObjects=$processedObjects $endTimeUnix" --skip-verify
            if [[ $arrayJobsSessions = "1000" ]]; then
                break
            else
            arrayJobsSessions=$arrayJobsSessions+1
            fi
        fi
    done
    arrayJobs=$arrayJobs+1
done

##
# Veeam Backup for Microsoft 365 Restore Portal. This part will check the if Restore Portal is enabled
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/RestorePortalSettings"
veeamRestorePortalUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

    restorePortalAppId=$(echo "$veeamRestorePortalUrl" | jq --raw-output ".applicationId")
    restorePortalEnabled=$(echo "$veeamRestorePortalUrl" | jq --raw-output ".isEnabled")
    case $restorePortalEnabled in
        false)
            restorePortal="1"
        ;;
        true)
            restorePortal="2"
        ;;
    esac

    #echo "veeam_office365_restoreportal,organization=$organization,restorePortalAppId=$restorePortalAppId restorePortalEnabled=$restorePortal"
    echo "Writing veeam_office365_restoreportal to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_restoreportal,veeamServer=$veeamRestServer,restorePortalAppId=$restorePortalAppId restorePortalEnabled=$restorePortal" --skip-verify

##
# Veeam Backup for Microsoft 365 RBAC Roles. This part will check the the RBAC Roles, and what privileges they have
##
veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/RbacRoles"
veeamRbacRoleUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

declare -i arrayRbacRoles=0
for id in $(echo "$veeamRbacRoleUrl" | jq -r '.[].id'); do
    rbacRoleId=$(echo "$veeamRbacRoleUrl" | jq --raw-output ".[$arrayRbacRoles].id")
    rbacRoleName=$(echo "$veeamRbacRoleUrl" | jq --raw-output ".[$arrayRbacRoles].name" | awk '{gsub(/ /,"\\ ");print}')
    rbacRoleDescription=$(echo "$veeamRbacRoleUrl" | jq --raw-output ".[$arrayRbacRoles].description" | awk '{gsub(/ /,"\\ ");print}')
    rbacRoleType=$(echo "$veeamRbacRoleUrl" | jq --raw-output ".[$arrayRbacRoles].roleType" | awk '{gsub(/ /,"\\ ");print}')
    rbacRoleOrganizationId=$(echo "$veeamRbacRoleUrl" | jq --raw-output ".[$arrayRbacRoles].organizationId")

    ## Getting the Organization Name
    veeamVBOrbacUrl="$veeamRestServer:$veeamRestPort/v7/Organizations/$rbacRoleOrganizationId"
    veeamVBOrbacUrlresult=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOrbacUrl" 2>&1 -k --silent)
    rbacOrganization=$(echo "$veeamVBOrbacUrlresult" | jq --raw-output '.name')


    ## Check the RBAC Restore Operators
    veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/RbacRoles/$rbacRoleId/operators"
    veeamRbacRoleOperatorUrl=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)

    declare -i arrayRbacRolesOperators=0
    for id in $(echo "$veeamRbacRoleOperatorUrl" | jq -r '.[].type'); do
        rbacRoleScopeType=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].type")

        case $rbacRoleScopeType in
        User)
            rbacROName=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].user.displayName" | awk '{gsub(/ /,"\\ ");print}')
            rbacRO365Name=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].user.name" | awk '{gsub(/ /,"\\ ");print}')
            #echo "veeam_office365_rbac_operators,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=User,rbacROName=$rbacROName,rbacRO365Name=$rbacRO365Name rbacRoleAdminId=$arrayRbacRolesOperators"
            echo "Writing veeam_office365_rbac_operators to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_rbac_operators,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=User,rbacROName=$rbacROName,rbacRO365Name=$rbacRO365Name rbacRoleAdminId=$arrayRbacRolesOperators" --skip-verify
        ;;
        Group)
            rbacROName=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].group.displayName" | awk '{gsub(/ /,"\\ ");print}')
            rbacRO365Name=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].group.name" | awk '{gsub(/ /,"\\ ");print}')
            rbacRO365Type=$(echo "$veeamRbacRoleOperatorUrl" | jq --raw-output ".[$arrayRbacRolesOperators].group.type")
            #echo "veeam_office365_rbac_operators,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=$rbacRoleScope365Type,rbacROName=$rbacROName,rbacRO365Name=$rbacRO365Name rbacRoleAdminId=$arrayRbacRolesOperators"
            echo "Writing veeam_office365_rbac_operators to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_rbac_operators,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=$rbacRO365Type,rbacROName=$rbacROName,rbacRO365Name=$rbacRO365Name rbacRoleAdminId=$arrayRbacRolesOperators" --skip-verify
        ;;
        esac
        arrayRbacRolesOperators=$arrayRbacRolesOperators+1
    done
    echo $rbacRoleType
    if [[ "$rbacRoleType" != "EntireOrganization" ]]; then
    ## Check the RBAC Selected Items per Role
    veeamVBOUrl="$veeamRestServer:$veeamRestPort/v7/RbacRoles/$rbacRoleId/selectedItems"
    veeamRbacRoleUrlScope=$(curl -X GET --header "Accept:application/json" --header "Authorization:Bearer $veeamBearer" "$veeamVBOUrl" 2>&1 -k --silent)
    
    declare -i arrayRbacRolesScope=0
    for id in $(echo "$veeamRbacRoleUrlScope" | jq -r '.[].type'); do
        rbacRoleScopeType=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].type")

        case $rbacRoleScopeType in
        User)
            rbacRoleScopeName=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].user.displayName" | awk '{gsub(/ /,"\\ ");print}')
            rbacRoleScope365Name=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].user.name" | awk '{gsub(/ /,"\\ ");print}')
            #echo "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=User,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScope365Name rbacRoleScopeId=$arrayRbacRoles"
            echo "Writing veeam_office365_rbac_scope to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=User,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScope365Name rbacRoleScopeId=$arrayRbacRoles" --skip-verify
        ;;
        Group)
            rbacRoleScopeName=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].group.displayName" | awk '{gsub(/ /,"\\ ");print}')
            rbacRoleScope365Name=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].group.name" | awk '{gsub(/ /,"\\ ");print}')
            rbacRoleScope365Type=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].group.type")
            #echo "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=$rbacRoleScope365Type,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScope365Name rbacRoleScopeId=$arrayRbacRoles"
            echo "Writing veeam_office365_rbac_scope to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=$rbacRoleScope365Type,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScope365Name rbacRoleScopeId=$arrayRbacRoles" --skip-verify
        ;;
        Site)
            rbacRoleScopeName=$(echo "$veeamRbacRoleUrlScope" | jq --raw-output ".[$arrayRbacRolesScope].site.title" | awk '{gsub(/ /,"\\ ");print}')
            #echo "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=Site,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScopeName rbacRoleScopeId=$arrayRbacRoles"
            echo "Writing veeam_office365_rbac_scope to InfluxDB" 
            influx write \
            -t "$veeamInfluxDBToken" \
            -b "$veeamInfluxDBBucket" \
            -o "$veeamInfluxDBOrg" \
            -p s \
            "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=Site,rbacRoleScopeName=$rbacRoleScopeName,rbacRoleScope365Name=$rbacRoleScopeName rbacRoleScopeId=$arrayRbacRoles" --skip-verify
        ;;
        esac
        arrayRbacRolesScope=$arrayRbacRolesScope+1
    done
    elif [[ "$rbacRoleType" = "EntireOrganization" ]]; then
        #echo "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=EntireOrganization,rbacRoleScopeName="EntireOrganization",rbacRoleScope365Name=$EntireOrganization rbacRoleScopeId=$arrayRbacRoles"
        echo "Writing veeam_office365_rbac_scope to InfluxDB" 
        influx write \
        -t "$veeamInfluxDBToken" \
        -b "$veeamInfluxDBBucket" \
        -o "$veeamInfluxDBOrg" \
        -p s \
        "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleName=$rbacRoleName,type=EntireOrganization,rbacRoleScopeName="EntireOrganization",rbacRoleScope365Name="EntireOrganization" rbacRoleScopeId=$arrayRbacRoles" --skip-verify
    fi     
    #echo "veeam_office365_rbac_roles,organization=$rbacOrganization,rbacRoleId=$rbacRoleId,rbacRoleName=$rbacRoleName,rbacRoleDescription=$rbacRoleDescription,rbacRoleType=$rbacRoleType rbacRoleAdminId=$arrayRbacRoles"
    echo "Writing veeam_office365_rbac_scope to InfluxDB" 
    influx write \
    -t "$veeamInfluxDBToken" \
    -b "$veeamInfluxDBBucket" \
    -o "$veeamInfluxDBOrg" \
    -p s \
    "veeam_office365_rbac_scope,organization=$rbacOrganization,rbacRoleId=$rbacRoleId,rbacRoleName=$rbacRoleName,rbacRoleDescription=$rbacRoleDescription,rbacRoleType=$rbacRoleType rbacRoleAdminId=$arrayRbacRoles" --skip-verify
    arrayRbacRoles=$arrayRbacRoles+1
done