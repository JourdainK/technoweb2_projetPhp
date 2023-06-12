<?php

extract($_POST,EXTR_OVERWRITE);

$infoReady = false;

if(!empty($mail) && !empty($pass) && !empty($nom) && !empty($ville) && !empty($pays)){
    $Ville = new Ville($cnx);
    $idville = $Ville->getVilleID($ville);
    if($idville == null){
        $Ville->addVille($ville, $pays,$codep);
        $idville = $Ville->getVilleID($ville);
    }
    $infoReady = true;
}
else {
    //https://stackoverflow.com/questions/11869662/display-alert-message-and-redirect-after-click-on-accept
    echo "<script>alert('Veuillez remplir tous les champs !');

    window.location.href='index.php?page=createAccount.php';</script>";
}


if($infoReady){
    $client = new client($cnx);
    $toRegister = $client->addClient($nom, $pass, $mail, $idville);
    echo "<script>alert('Inscription réussie !');

    window.location.href='index.php?page=accueil.php';</script>";
}

