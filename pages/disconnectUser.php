<?php
session_destroy();

header('Location: ?page=accueil.php');

/*
//that works too
echo "<script>alert('Au revoir !');

    window.location.href='index.php?page=accueil.php';</script>";;
*/