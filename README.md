# Virtualité
Virtualité permet la création d'environnements 3D directement en réalité virtuelle. Des modèles 3D en format OBJ ainsi que des images en format PNG peuvent facilement être importés dans ces environnements 3D en réalité virtuelle et manipulés avec une panoplie d'outils virtuels pour construire des scènes.

Pour utiliser Virtualité, le casque Quest doit être en mode développeur. Pour savoir la marche à suivre, vous pouvez regarder cette vidéo (en anglais): https://www.youtube.com/watch?v=Yblp3LH1UAI

Pour savoir comment utiliser les outils sur PC, regardez cette vidéo: https://youtu.be/JfkDjf5JvMs

Et pour utiliser l'application elle-même en RV, voici le tutoriel: https://youtu.be/Hvd65-7vJbo



# Configurations avancées



- Reformatter un fichier de sauvegarde

Pour reformatter un fichier de sauvegarde qui a été sauvegardé sur un ordinateur à l'aide du script de sauvegarde, utilisez le site web suivant : https://jsonformatter.org/



- Modifier un fichier de sauvegarde

Pour ajouter des modèles 3D .obj après la chargement initial du projet, ouvrir le fichier "sauvegarde.json" dans un éditeur de fichier texte comme Notepad ou Notepad++ (éviter Microsoft Word ou Open Office).
Par la suite, repérez une section du fichier JSON comme celle-ci : 

```
{
	"model": "%_MODEL1",
	"transform": {
		"location": {
			"x": 2616.500732421875,
			"y": -1594.51318359375,
			"z": 176.33042907714844
		},
		"rotation": {
			"x": -51.778961181640625,
			"y": -86.823486328125,
			"z": -125.59280395507812
		},
		"scale": {
			"x": 25.561494827270508,
			"y": 25.561494827270508,
			"z": 25.561494827270508
		}
	},
	"material": {
		"brightness": "0.0",
		"reflectionFactor": "150.0",
		"texture": "EmptyTex",
		"color": {
			"r": 1.0,
			"g": 1.0,
			"b": 1.0
		},
		"light": "0"
	},
	"lock": false,
	"group": "",
	"isApplied": false,
	"appliedStructs": {
		"structs": []
	}
},
```

Assurez vous d'avoir repérer une section où le nom du "model" commence par '%_MODEL' suivi d'un nombre.

Remplacez le nom du "model" par "Content/" suivi du nom du fichier .obj que vous voulez ajouter. Par example : "Content/Feuille.obj".

Par la suite, assurez-vous de modifier les valeurs "x", "y" et "z" du "scale" et de la "location". Le "x, "y" et "z" du "scale" devraientt être d'environ 25.0 et le "x" et le "y" de la "location" devraient être d'environ 0.0 et le "z" d'environ 100.0.
Ces valeurs sont sujettes à changement en fonction des objets déja placés dans la pièces. Une autre possibilité est de copier les valeurs d'une autre section de "location" dans le fichier JSON.