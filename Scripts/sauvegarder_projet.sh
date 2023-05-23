#!/bin/bash

downloadFilesFromDevice()
{
	objs="$(./platform-tools/adb.exe shell ls sdcard/UE4Game/Virtualite/Virtualite/Content/*.obj)"
	pngs="$(./platform-tools/adb.exe shell ls sdcard/UE4Game/Virtualite/Virtualite/Content/*.png)"
	
	echo "$(./platform-tools/adb.exe pull sdcard/UE4Game/Virtualite/Virtualite/Content/savefile.json ../Projet)" | tee -a "log"
	
	while IFS= read -r line<&3; do
		fixedLine=$(echo ${line})
		echo "$(./platform-tools/adb.exe pull ${fixedLine} ../Projet)" | tee -a "log"
	done 3< "${objs}"
	
	while IFS= read -r line<&4; do
		fixedLine=$(echo ${line})
		echo "$(./platform-tools/adb.exe pull ${fixedLine} ../Projet)" | tee -a "log"
	done 4< "${pngs}"
	
	allObjs="$(ls ../Projet/*.obj | sed -e "s|../Projet/||g")"
	
	echo "allObjs : ${allObjs}" | tee -a "log"

	IFS="
	"
	for lineObj in $(echo "${allObjs}"); do
		if [ ! -z "${lineObj}" ] ; then
			echo "lineObj : ${lineObj}"
			alreadyExists="$(grep "${lineObj}" ../Projet/modelesAleatoires.txt)"
			echo "alreadyExists when saving : ${alreadyExists}" | tee -a "log"
			
			if [ -z "${alreadyExists}" ] ; then
				echo "${lineObj}" | tee -a "../Projet/modelesAleatoires.txt"
			fi
		fi
	done
}

downloadFilesFromDevice

echo "DONE"

sleep 2

