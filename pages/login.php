<?php
if(isset($_POST['submit_login'])){
    $admin = new AdminDB($cnx); // $cnx est dans l'index
    $adm = $admin->isAdmin($_POST['login'],$_POST['password']);
    if($adm == 1){
        $_SESSION['admin'] = 1;
        unset($_SESSION['page']);
        print '<meta http-equiv="refresh": content="0;url=./admin/index.php">';
    }else {
        $client = new client($cnx);
        $cli = $client->isClient($_POST['login'],$_POST['password']);

        if($cli){
            $mail_client = $_POST['login'];
            //class client -> getClientByMail
            $_SESSION['client'] = $mail_client;
            $_SESSION['client_id'] = $client->getClientByMail($mail_client)['id_client'];
            unset($_SESSION['page']);
            print '<meta http-equiv="refresh": content="0;url=./index.php">';
        }else{
            print '<br><br>';
            print "Vous n'êtes pas enregistré, veuillez vous inscrire";
        }
        print '<br><br>';
        print "Accès réservé";
    }

}

?>
<div class="container pt-3">
    <div class="row">
        <div class="col align-item-center pt-5" style="width: 50%">
            <h2 class="text-center">Connexion</h2>

            <form action="<?php print $_SERVER['PHP_SELF'];?>" method="post">
                <div class="mb-3">
                    <label for="login" class="form-label">Email :</label>
                    <input type="text" class="form-control" id="login" name="login">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mot de passe : </label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <div class="d-flex justify-content-between mb-3">
                    <button type="submit" name="submit_login" id="submit_login" class="btn btn-dark">Envoyer</button>
                    <a href="index.php?page=createAccount.php" class="align-self-right text-right btn btn-dark text-light" role="button" alt="Lien créér compte">Créer un compte client</a>
                </div>
            </form>

        </div>

        <div class="col pt-5 text-center">
            <img src="../images/bandeau3.jpg" title="carlin is watching" alt="Photo de George Carlin">
        </div>

    </div>

</div>

