<?php
header('Content-Type: application/json');
 require '../pgConnect.php';
 require '../class/Connexion.class.php';
 require '../class/Hydrate.class.php';
 require '../class/produits.class.php';
 $cnx = Connexion::getInstance($dsn,$user,$pass);

$pr = new produits($cnx);
$prods[] = $pr->deleteProd($_POST['id_produit']);

print json_encode($prods);