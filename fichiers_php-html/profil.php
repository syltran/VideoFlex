<?php
session_start();

$id_profil = $_SESSION["id_profil"];
?>

<!DOCTYPE html>
<html lang=fr>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>
		<?php
		require("connexion.inc.php");

		$nom = $cnx->query("SELECT nom FROM profil WHERE id_profil = $id_profil");
		echo $nom->fetch()["nom"];
		?>
	</title>

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
	<form action="compte.php" method="post">
		<input type="submit" name="back" value="retour"/>
	</form>

	<p>
	<?php
	require("barre_recherche.php");
	?>
	</p>

	<p>
	<?php
	require("video_en_cours.php");
	?>
	</p>

	<p>
	<?php
	require("top_film.php");
	?>
	</p>

	<p>
	<?php
	require("suggestion.php");
	?>
	</p>

</body>
</html>
