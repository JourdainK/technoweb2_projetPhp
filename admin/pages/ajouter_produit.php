<?php
$cat = new Categorie($cnx);
$categories = $cat->getAllCategories();
$nbrcateg = count($categories);
//TODO reprendre ici -> ajoutProd

if (isset($_POST['submit_form'])) {
    extract($_POST, EXTR_OVERWRITE);
    if(!empty($nom) && !empty($descrip) && !empty($prix) && !empty($file)){

        if (isset($_FILES["file"]) && $_FILES["file"]["size"] > 0) {
            $target_dir = "../images/";
            $target_file = $target_dir . basename($_FILES["file"]["name"]);
            $uploadOk = 1;
            $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

            if (isset($_POST["submit_form"])) {
                $check = getimagesize($_FILES["file"]["tmp_name"]);

                if ($check !== false) {
                    echo "Le fichier est une image : " . $check["mime"] . ".";
                    $uploadOk = 1;
                } else {
                    echo "Erreur : le fichier n'est pas une image.";
                    $uploadOk = 0;
                }

            }
            if (!empty($imageFileType)) {
                if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
                    echo "<br>Désolé, seuls les formats JPG, JPEG, PNG et GIF sont autorisés.";
                    $uploadOk = 0;
                }

                if (file_exists($target_file)) {
                    echo "<br>Désolé, le fichier a déjà été chargé.";
                    $uploadOk = 0;
                }
            }


            if ($uploadOk == 0) {
                echo "<br>Erreur lors du chargement du fichier.";
            } else {

                if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
                    echo '<p class="pt-5">';
                    echo "Le fichier : " . htmlspecialchars(basename($_FILES["file"]["name"])) . " a été chargé correctement.";
                    echo '</p>';
                    //print '<br><p>Fichier uploadé : </p><br><img class="pics" src="../images/' . htmlspecialchars(basename($_FILES["file"]["name"])) . '">';
                } else {
                    echo "<br>Pas de fichier chargé par l'utilisateur.";
                }

            }

        }

    }


    //TODO traitement php, langage serveur ajout produit
}
?>


    <h2 class="text-center mt-5 pt-5"> Ajout d'un produit </h2>
    <div class="row">

        <div class="col-6 text-center align-content-center pt-5 mt-5">
            <img src="../images/prods.jpg" title="carlin is watching" alt="Photo de George Carlin" class="rounded" style="width: 60%">
            <div id="inDB" class="text-light">

            </div>
        </div>


        <div class="col-6 text-center align-content-center">
            <div class="row pt-3  justify-content-center" style="width: 50%;">
                <form class="form-group" action="<?php print $_SERVER['PHP_SELF']; ?>" method="POST" enctype="multipart/form-data">

                    <div class="mb-3">
                        <label for="nomInput" class="form-label">Nom : </label>
                        <input name="nom" type="text" class="form-control" id="nomInput" aria-describedby="nomHelp">
                        <div id="nomHelp" class="form-text text-light" >Entrer le nom du produit.</div>
                    </div>

                    <div class="mb-3">
                        <p>Catégorie :</p>
                        <?php for ($i = 0; $i < $nbrcateg; $i++) { ?>
                            <input type="radio" name="cont" class="cate" id="cat"
                                   value="<?php echo $categories[$i]->id_categorie; ?>"/>
                            <label for="cont_<?php echo $categories[$i]->id_categorie; ?>"><?php echo $categories[$i]->nom_categorie; ?></label><br>
                        <?php } ?>
                    </div>


                    <div class="mb-3">
                        <label for="descriptInput" class="form-label">Description : </label>
                        <textarea name="descrip" class="form-control" id="descriptInput" rows="3"></textarea>
                        <div id="descripHelp" class="form-text text-light">Entrer la description du produit.</div>
                    </div>
                    <div class="mb-3">
                        <label for="prixInput" class="form-label">prix : </label>
                        <input name="prix" type="number" step="0.01" class="form-control" id="prixInput1" aria-describedby="prixHelp">
                        <div id="prixHelp" class="form-text text-light">Entrer le prix du produit.</div>
                    </div>
                    <div class="col-md-6">
                        <br><label for="file">Ajouter une photo du produit :</label><br>
                        <input name="file" type="file" class="form-control" name="file" id="file" accept="image/png,image/jpeg">
                    </div>
                    <br>

                    <button type="submit" name="submit_form" id="submit_prod" class="btn btn-dark mb-3">Valider</button>


                </form>

            </div>

        </div>

    </div>




