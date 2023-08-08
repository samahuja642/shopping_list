#!/bin/bash
option1="Select List"
while [ "$option1" != "Cancel" ]
do
option1=$(echo -e "New List\nSelect List\nRemove List\nCancel" | fzf)
if [ "$option1" = "New List" ];
then
    echo "Do you want default name or any specific?";
    default=$(echo -e "Default Name\nSpecific" | fzf)
    if [ "$default" = "Default Name" ];
    then
	touch lists/$( date +"%d%m%Y%H%M%S" )
    else
	read -p "Specific Name : " filename;
	touch lists/${filename}
    fi
elif [ "$option1" = "Remove List" ];
then
    name=$( ls lists/ | fzf )
    rm lists/$name
elif [ "$option1" = "Select List" ];
then
    list_name=$( ls lists/ | fzf-tmux -d 10 )
    choice="Add Item"
    while [ "${choice}" != "Exit" ];
    do
	choice=$( echo -e "Add Item\nRemove Item\nShow List\nExit" | fzf )
	if [ "${choice}" = "Add Item" ];
	then
	    read -p "New Item Name : " item
	    echo "${item}" >> ./lists/$list_name
	elif [ "${choice}" = "Remove Item" ];
	then
	    item=$( cat lists/$list_name | fzf )
	    echo $item
	    sed -i "/^${item}$/D" lists/$list_name 
	elif [ "${choice}" = "Show List" ];
	then
	    cat lists/$list_name | fzf
	fi    
    done
fi
done
