function describeresourcesadmin () {
	echo "**In describe resources as admin function :file $1 :ownerid $OWNERID :username $USERNAME" >> $1
	echo "**Addresses:"						>> $1
	euca-describe-addresses verbose| grep $OWNERID			>> $1 # tested leaves reservation
	echo "**Security groups:"						>> $1
	euca-describe-group verbose --filter owner-id=$OWNERID		>> $1 # tested sec groups are left behind
	echo "**Images:"							>> $1
	euca-describe-images -a --filter owner-id=$OWNERID		>> $1
	echo "**Instances:"						>> $1
	euca-describe-instances verbose --filter owner-id=$OWNERID	>> $1
	#euca-describe-keypairs verbose	>> $1 # tested keypairs are left behind - need to implement  --filter owner-id=$OWNERID
	echo "**EBS snapshots:"						>> $1
	euca-describe-snapshots verbose --filter owner-id=$OWNERID	>> $1
	#euca-describe-tags	>> $1 # can these be left behind ? need to implement  --filter owner-id=$OWNERID
	#euca-describe-volumes no way to do this by euca-commands - need to run SQL query to euca DB
	#euare- list roles
	#euare list profiles
	echo "**Users Certificates:"					>> $1
	euare-userlistcerts -u=$USERNAME --as-account=$USERNAME		>> $1
	echo "**Users groups:"						>> $1
	euare-userlistgroups -u=$USERNAME --as-account=$USERNAME        >> $1 # does not show empty groups
	echo "**All Groups in cloud with users in them:"		>> $1 # does not show empty groups
	euare-grouplistbypath						>> $1
	echo "**Users access keys:"					>> $1
	euare-userlistkeys -u=$USERNAME --as-account=$USERNAME		>> $1
	echo "**Users policies:"					>> $1
	euare-userlistpolicies -u=$USERNAME --as-account=$USERNAME	>> $1
	echo "**Users load balacers:"					>> $1
	eulb-describe-lbs --show-long | grep $OWNERID			>> $1  # create euca ticket for --filter
	#euscale-describe-auto-scaling-instances # How to find out this particular users data ??
	#euscale-describe-auto-scaling-groups  # How to find out this particular users data ??
	#euscale-describe-launch-configs  # How to find out this particular users data ??
	#euscale-describe-policies  # How to find out this particular users data ??
	#euform-list-stacks # How to find out this particular users data ??
}

function describeresources () {
	echo "In describe resources function: $1"
	euare-accountgetsummary			>> $1
	euca-describe-addresses			>> $1
        euca-describe-group			>> $1
        euca-describe-images --filter owner-id=$EC2_ACCOUNT_NUMBER  >> $1
        euca-describe-instances			>> $1
        euca-describe-keypairs			>> $1
        euca-describe-snapshots			>> $1
        euca-describe-tags			>> $1
        euca-describe-volumes			>> $1
        euare-userlistcerts			>> $1
        euare-grouplistbypath			>> $1
        euare-userlistkeys			>> $1
        euare-userlistpolicies -u=$USERNAME	>> $1
        eulb-describe-lbs --show-long		>> $1
        euscale-describe-auto-scaling-instances >> $1
        euscale-describe-auto-scaling-groups	>> $1
        euscale-describe-launch-configs		>> $1
        euform-list-stacks 			>> $1
        #VPC euca-describe-internet-gateways	>> $1
        #VPC euca-describe-network-interfacesc	>> $1
        #VPC euca-describe-vpcs			>> $1
        #VPC euca-describe-subnets		>> $1
}
