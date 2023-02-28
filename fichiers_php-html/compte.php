<?php
session_start();

$mail = $_SESSION["mail"];
$mdp = $_SESSION["mdp"];

$id_compte = $_SESSION["id_compte"];
$nom = $_SESSION["nom"];
$prenom = $_SESSION["prenom"];
$adresse = $_SESSION["adresse"];
$type_abo = $_SESSION["type_abo"];
$datefin_abo = $_SESSION["datefin_abo"];
?>

<!DOCTYPE html>
<html lang=fr>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<title>Mon compte</title>
	<style>
		body {
			background-color:#ffd;
			font-family:Verdana,Helvetica,Arial,sans-serif;
		}
	</style>
</head>

<body>
	<?php
	require("bouton_deco.html");
	?>

	<h1>Mon compte</h1>
	<?php
	require("info_compte.php");
	?>

    <h3>Qui est-ce ?</h3>
    <?php
	require("redirige_profil.php");
	?>

	<h3>Ajouter/Supprimer un profil</h3>
	<?php
	require("insertion_profil.php");
	?>

</body>
</html>
