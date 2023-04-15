<?php
if(isset($_POST['submit_login'])){
    $admin = new AdminDB($cnx); // $cnx est dans l'index
    $adm = $admin->isAdmin($_POST['login'],$_POST['password']);
    print 'TEST' ;
    var_dump($adm);
    if($adm == 1){
        $_SESSION['admin'] = 1;
        print '<meta http-equiv="refresh": content="0;url=./admin/index.php">';
    }else {
        //TODO entrée client ? > si pas admin ? client -> class client -> check si client inscrit -> si client inscrit -> SESSION[client]
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
                    <label for="login" class="form-label">Email address</label>
                    <input type="text" class="form-control" id="login" name="login">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <button type="submit" name="submit_login" id="submit_login" class="btn btn-primary">Envoyer</button>
            </form>

        </div>

        <div class="col pt-5 text-center">
            <img src="../images/bandeau3.jpg" title="carlin is watching" alt="Phpoto de George Carlin">
        </div>

    </div>

</div>

