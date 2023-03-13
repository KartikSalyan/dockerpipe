# Set the ACR name and maximum number of tags to keep
$acrName = "practiceregistryy"
$acrRepository = "practiceregistryy/practiceregistryy"
$maxTags = 1

sudo az acr login --name $acrName
#Get the number of tags
$tagsCount = (az acr repository show-tags --name $acrName --repository $acrRepository).length-2

if ($tagsCount -gt $maxTags){
	sudo az acr repository show-tags -n $acrName --repository $acrRepository --orderby time_asc --top 1 --query "[0]" --output tsv | 
	foreach { 
		sudo az acr repository delete --name $acrName --image ${acrRepository}:$_ --yes 
	}
}
