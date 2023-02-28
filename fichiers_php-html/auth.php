<?php
session_start();

?>

<!DOCTYPE html>
<html lang=fr>
<head>
	<meta charset="utf-8" />
	<title>Identification</title>
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

<h1>S'identifier</h1>

<form action="auth.php" method="post">
	<p>
        E-mail: <input type="text" name="mail" /><br/>
		Mot de passe: <input type="password" name="mdp" />
    </p>
	<p>
        <input type="reset" name="reset" value="Effacer" /> 
        <input type="submit" name="submit" value="S'identifier" />
    </p>
</form>

<?php
    require("verif_auth.php");
?>

</body>
</html>
