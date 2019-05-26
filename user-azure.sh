#!/bin/bash
username=$1


# valiadation for az
if [ -z "$(which az)" ]; then
echo "azure-cli not installed"
exit 1
fi

creation()
{
userdisplayname=$1
DOMAIN=pallepegasiangmail.onmicrosoft.com
userprincipalname=$userdisplayname@$DOMAIN
random=$3
usersubcription=$2
#create user if he doesn't exists
result=$(az ad user list --query [].userPrincipalName | grep -E $userprincipalname)
if [ -z "$result" ]; then
az ad user create --display-name $userdisplayname --user-principal-name  $userprincipalname --force-change-password-next-login  --password $random --subscription $usersubcription
echo "user created"
fi
}
#Assignment creation 

assignment()
{
username=$1
DOMAIN=pallepegasiangmail.onmicrosoft.com
userprincipalname=$userdisplayname@$DOMAIN
action=$2
role=$3
result=$(az ad user list --query [].userPrincipalName | grep -E $userprincipalname)
if [ -z "$result" ]; then
echo "try different user, it's not in list"
exit 1
fi

if [ $action != "create" ] && [ $action != "delete" ]; then 
echo "not a valid action"
exit 1
fi

if [ $role != "reader" ] && [ $role != "contributor" ]; then 
echo "not a valid role to assign"
exit 1
fi

az role assignment $action  --assignee $username  --role $role
echo "role assigned sucessfully"
}

deletion()
{

userprincipalname=$1
result=$(az ad user list --query [].userPrincipalName | grep -E $userprincipalname)

if [ -z "$result" ]; then
echo "the user does not currently exist"
exit 1
fi


admin=$(az role assignment list  --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)

if [ -n "$admin" ]; then
echo "can not delete user that is an admin"
exit 1
fi

az ad user delete --upn-or-object-id $userprincipalname
echo "user deleted successfully"
}

admin=$(az role assignment list --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E $username)

if [ -z "$admin" ]; then 
echo "you must be an admin to access this file"
exit 1
fi


command=$2
$command $3 $4 $5

exit 0