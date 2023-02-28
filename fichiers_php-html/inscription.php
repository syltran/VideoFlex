<?php
session_start();

?>

<!DOCTYPE html>
<html lang=fr>
<head>
	<meta charset="utf-8" />
	<title>Inscription</title>
	<style type="text/css">
		body {
			background-color:#ffd;
			font-family:Verdana,Helvetica,Arial,sans-serif;
		}
	</style>
</head>

<body>
	<form action="accueil.php" method="post">
		<input type="submit" name="back" value="retour"/>
	</form>

    <h1>S'inscrire</h1>
    <p>
    <?php
    require("verif_inscription.php");
    ?>
    </p>

</body>
</html>
