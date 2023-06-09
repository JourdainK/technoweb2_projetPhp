<?php
session_start();
include './lib/php/admin_liste_include.php';
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="../lib/css/main.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    <script src="../lib/js/fonction_admin.js"></script>
    <title>George Carlin's Fansite</title>
</head>
<body>
<header id=header">

</header>
<nav>
    <?php
    if(file_exists('./lib/php/menu_admin.php')){
        include('./lib/php/menu_admin.php');
    }
    ?>
</nav>

<section id="mains">

    <div id="main pt-5">
        <?php
        if (!isset($_SESSION['page'])) {
            $_SESSION['page'] = "accueil.php";
        }
        if (isset($_GET['page'])) {
            //si on a un param page dans l'url
            $_SESSION['page'] = $_GET['page'];
        }
        $path = "./pages/" . $_SESSION['page'];
        //print "path: " . $path . "<br>";
        if (file_exists($path)) {
            include ($path);
        } else {
            include ("./pages/page404.php");
        }
        ?>
    </div>
</section>


<nav class="navbar bottom navbar-expand- navbar-dark bg-dark">
    <a target="_blank" href="https://georgecarlin.com/">G. Carlin : site officiel</a>
    <a target="_blank" href="https://www.imdb.com/name/nm0137506/?ref_=nv_sr_1">IMDB : filmographie</a>
    <a target="_blank" href="https://en.wikiquote.org/wiki/George_Carlin">Carlin citations</a>
    <a target="_blank" href="https://fr.wikipedia.org/wiki/George_Carlin">Wikipedia : G. Carlin</a>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

</body>
</html>