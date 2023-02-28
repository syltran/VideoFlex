<?php
session_start();

if (isset($_POST["deco"])){
    session_unset(); //detruit toutes les variables de la session courante
}
?>

<!DOCTYPE html>
<html lang=fr>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<title>VideoFlex</title>
	<style>
		body {
			background-color:#ffd;
			font-family:Verdana,Helvetica,Arial,sans-serif;
		}
	</style>
</head>

<body>
    <div>
    <img src = "logo.jpg" height="200" width="200"
        alt = "logo VideoFlex">
    </div>    

    <div>
    <form action="inscription.php" method="post">
        <p>
        <input type="submit" name="inscription" value="S'inscrire"/>
        </p>
    </form>
    </div>

    <div>
    <form action="auth.php" method="post">
        <p>
        <input type="submit" name="auth" value="S'identifier"/>
        </p>
    </form>
    </div>
	
</body>
</html>
