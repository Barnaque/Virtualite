echo "starting."

argToUpload="../Projet"
permission="${1}"


echo "this is permission : ${permission}"

if [ -z "${permission}" ] ; then
	echo "$(./platform-tools/adb.exe pull sdcard/UE4Game/Virtualite/Virtualite/Content/rights ./rights_tmp)" | tee -a "log"
	if [ -f "./rights_tmp" ] ; then
		permission="$(cat ./rights_tmp)"
		rm ./rights_tmp
	else
		permission="user"
	fi
fi

cp "${argToUpload}/savefile.json" "tmp.json"
#echo $(cat "${argToUpload}/savefile.json") > "tmp.json"
 
 echo "after copy"
 
uploadArgToDevice() #_argToUpload
{
	_argToUpload="${1}"
	
	
	echo "$(./platform-tools/adb.exe shell am force-stop com.Barnaque.Virtualite)" | tee -a "log"
	
	sleep 1
	
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/savefile.json)" | tee -a "log"
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/*.obj)" | tee -a "log"
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/*.png)" | tee -a "log"
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/rights)" | tee -a "log"
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/projectname)" | tee -a "log"
	echo "$(./platform-tools/adb.exe shell rm sdcard/UE4Game/Virtualite/Virtualite/Content/load)" | tee -a "log"
	sleep 0.1
	echo "$(./platform-tools/adb.exe push ${_argToUpload}/*.obj sdcard/UE4Game/Virtualite/Virtualite/Content)" | tee -a "log"
	echo "$(./platform-tools/adb.exe push ${_argToUpload}/*.png sdcard/UE4Game/Virtualite/Virtualite/Content)" | tee -a "log"
	sleep 0.1
	echo "$(./platform-tools/adb.exe push tmp.json sdcard/UE4Game/Virtualite/Virtualite/Content/savefile.json)" | tee -a "log"
	sleep 1
	echo "load" > load
	echo "$(./platform-tools/adb.exe push "load" sdcard/UE4Game/Virtualite/Virtualite/Content)" | tee -a "log"
	rm load
	sleep 1
	echo "${permission}" > rights
	echo "$(./platform-tools/adb.exe push "rights" sdcard/UE4Game/Virtualite/Virtualite/Content)" | tee -a "log"
	rm rights
	sleep 0.1
	projectName="$(basename ${_argToUpload})"
	echo "${projectName}" > projectname
	echo "$(./platform-tools/adb.exe push "projectname" sdcard/UE4Game/Virtualite/Virtualite/Content)" | tee -a "log"
	rm projectname
	sleep 0.1
	echo "$(./platform-tools/adb.exe shell am start -n com.Barnaque.Virtualite/com.epicgames.ue4.GameActivity)" | tee -a "log"
}

replaceEmptyModel() #_index, _model, _file
{
	_index="${1}"
	_model="$(echo -n "${2}" | sed -e "s|\n||g" | sed -e "s|\r||g")"
	_file="${3}"
	echo "will replace %_MODEL${_index}\" with Content/${_model}\" in savefile." | tee -a "log"
	echo "$(sed -e "s|%_MODEL${_index}\"|Content/${_model}\"|g" -i "${_file}")"
}

replaceEmptyTexture() #_index, _model, _file
{
	_index="${1}"
	_model="$(echo -n "${2}" | sed -e "s|\n||g" | sed -e "s|\r||g")"
	_file="${3}"
	echo "$(sed -e "s|%_TEXTURE${_index}|Content/${_model}|g" -i "${_file}")"
}



echo "$(cat "${argToUpload}"/modelesAleatoires.txt | xargs -n 1 basename)" | tee -a "log"
allObjs="$(cat "${argToUpload}"/modelesAleatoires.txt | xargs -n 1 basename | head -1)"

if [ "${allObjs}" = ALL ] ; then
	echo "allobjs is ALL"
	
	allObjs="$(ls ../Projet/*.obj | sed -e "s|../Projet/||g")"
	
	echo "allObjs : ${allObjs}" | tee -a "log"
	
	numberOfObjects="$(cat "${argToUpload}"/modelesAleatoires.txt | xargs -n 1 basename | grep ".obj" | wc -l)"
	
	index=$((numberOfObjects + 1))
	echo "index : ${index}"
	IFS="
	"
	for lineObj in $(echo "${allObjs}"); do
		if [ ! -z "${lineObj}" ] ; then
			echo "lineObj : ${lineObj}" | tee -a "log"
			alreadyExists="$(grep "${lineObj}" ../Projet/modelesAleatoires.txt)"
			echo "alreadyExists when loading : ${alreadyExists}" | tee -a "log"
			
			if [ -z "${alreadyExists}" ] ; then
				echo "currentIndex : ${index}"
				replaceEmptyModel "${index}" "${lineObj}" "tmp.json"
				index=$((index + 1))
			fi
			
			
			tightFilename="$(echo "${lineObj}" | sed -e "s| ||g")"
			echo "tightFilename : ${tightFilename}"
			
			if [ "${tightFilename}" != "${linePng}" ] ; then
				mv "../Projet/${lineObj}" ../Projet/"${tightFilename}"
			fi			
		fi
	done
	
else
	index=1
	IFS="
	"
	for lineObj in $(echo "${allObjs}"); do
		if [ ! -z "${lineObj}" ] ; then
			replaceEmptyModel "${index}" "${lineObj}" "tmp.json"
		fi
		index=$((index + 1))
	done
fi


echo "$(cat "${argToUpload}"/texturesAleatoires.txt | xargs -n 1 basename)" | tee -a "log"
allPngs="$(cat "${argToUpload}"/texturesAleatoires.txt | xargs -n 1 basename)"

index=1
IFS="
"
for linePng in $(echo "${allPngs}"); do
	if [ ! -z "${linePng}" ] ; then
		replaceEmptyTexture "${index}" "${linePng}" "tmp.json"
		tightFilename="$(echo "${lineObj}" | sed -e "s| ||g")"
		if [ "${tightFilename}" != "${linePng}" ] ; then
			mv "../Projet/${linePng}" ../Projet/"${tightFilename}"
		fi
	fi
	index=$((index + 1))
done



echo "after repalce empty"

sed -z 's/\n//g' -i tmp.json
sed -z 's/\r//g' -i tmp.json
sed -e "s| ||g" -i tmp.json
sed -e "s|\t||g" -i tmp.json

echo "after repalce line breaks in tmp.json"

uploadArgToDevice "${argToUpload}"

echo "after uploadargtodevice"

rm tmp.json

echo "DONE"

sleep 2

