<?php

if(isset($_POST['submit_user'])){
    extract($_POST, EXTR_OVERWRITE);
    if(!empty($mail) || !empty($pass) || !empty($nom) || !empty($ville) || !empty($pays)){
        $client = new client($cnx);
        $town = new Ville($cnx);
        $idville = $town->getVilleID($ville);
    }
}

?>

<div class="container">
    <br><br><br><br>
    <div class="row">

        <div class="col d-flex justify-content-center pb-4">
            <img src="../images/bandeau3.jpg" title="carlin is watching" alt="Photo de George Carlin">
            <br>
        </div>

        <div class="col ">
            <form action="?page=createAccount_user.php" method="POST" class="form-inline" id="inscriptionForm">

                <div class="mb-3 row d-flex justify-content-between">
                    <div class="col form-group">
                        <label for="mail" class="form-label">Email :</label>
                        <input type="email" class="form-control" id="mail" name="mail">
                    </div>

                    <div class="col form-group">
                        <!-- TODO protect mdp md5 -->
                        <label for="pass" class="form-label">Mot de passe : </label>
                        <input type="password" class="form-control" id="pass" name="pass">
                    </div>
                </div>

                <div class="mb-3 row d-flex justify-content-between">
                    <div class="col form-group">
                        <label for="nom" class="form-label">Nom : </label>
                        <input type="text" class="form-control" id="nom" name="nom">
                    </div>

                    <div class="col form-group">
                        <label for="pays" class="form-label">Pays : </label>
                        <input type="text" class="form-control" id="pays" name="pays">
                    </div>
                </div>

                <div class="mb-3 row d-flex justify-content-between">
                    <div class="col form-group">
                        <label for="ville" class="form-label">Ville : </label>
                        <input type="text" class="form-control" id="ville" name="ville">
                    </div>

                    <div class="col form-group">
                        <label for="codep" class="form-label">Code postal : </label>
                        <input type="number" class="form-control" id="codep" name="codep">
                    </div>
                </div>

                <div class="mb-3 row d-flex justify-content-between text-light">
                        <button type="submit" class="btn btn-dark" name="submit_inscrip" id="submit_user" style="width: 20%;">Inscription</button>
                        <button type="reset" class="btn btn-dark align-self-right" style="width: 20%">Effacer</button>
                </div>


            </form>
        </div>

    </div>
</div>
