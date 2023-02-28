<?php
session_start();

$titre_vid = $_SESSION["titre_vid"];
$id_profil = $_SESSION["id_profil"];
?>

<!DOCTYPE html>
<html lang=fr>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>
        <?php
        echo $titre_vid;
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
    <form action="video.php" method="post">
		<input type="submit" name="back" value="retour"/>
	</form>

    <p>
    <?php
    require("lecture_video.php");
    ?>
    </p>

</body>
</html>


