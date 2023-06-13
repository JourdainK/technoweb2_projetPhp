<?php
$cat = new Categorie($cnx);
$categories = $cat->getAllCategories();
$nbrcateg = count($categories);


//TODO fix -> insert (worked before trying to fix upload pic)
// need to handle file upload with ajax

?>

<h2 class="text-center mt-5 pt-5"> Ajout d'un produit </h2>
<div class="row">

    <div class="col-6 text-center align-content-center pt-5 mt-5">
        <img src="../images/prods.jpg" title="carlin is watching" alt="Photo de George Carlin" class="rounded"
             style="width: 60%">
        <div id="inDB" class="text-light">

        </div>
    </div>


    <div class="col-6 text-center align-content-center">
        <div class="row pt-3  justify-content-center" style="width: 50%;">
            <form id="uploadform" class="form-group" action="<?php print $_SERVER['PHP_SELF']; ?>" method="POST"
                  enctype="multipart/form-data">

                <div class="mb-3">
                    <label for="nomInput" class="form-label">Nom : </label>
                    <input name="nomProd" type="text" class="form-control" id="nom_produit" aria-describedby="nomHelp">
                    <div id="nomHelp" class="form-text text-light">Entrer le nom du produit.</div>
                </div>

                <div class="mb-3">
                    <p>Catégorie :</p>
                    <?php for ($i = 0; $i < $nbrcateg; $i++) { ?>
                        <input type="radio" name="id" class="cate" id="cat"
                               value="<?php echo $categories[$i]->id_categorie; ?>"/>
                        <label for="cont_<?php echo $categories[$i]->id_categorie; ?>"><?php echo $categories[$i]->nom_categorie; ?></label>
                        <br>
                    <?php } ?>
                </div>


                <div class="mb-3">
                    <label for="descrip" class="form-label">Description : </label>
                    <textarea name="descrip" class="form-control" id="descriptInput" rows="3"></textarea>
                    <div id="descripHelp" class="form-text text-light">Entrer la description du produit.</div>
                </div>
                <div class="mb-3">
                    <label for="prixInput" class="form-label">prix : </label>
                    <input name="prix" type="number" step="0.01" class="form-control" id="prixInput"
                           aria-describedby="prixHelp">
                    <div id="prixHelp" class="form-text text-light">Entrer le prix du produit.</div>
                </div>
                <!-- TODO fix upload pic -> ajax/php
                <div class="col-md-6">
                    <br><label for="file">Ajouter une photo du produit :</label><br>
                    <input name="file" type="file" id="file" class="form-control" accept="image/png,image/jpeg">

                </div>
                -->
                <br>

                <button type="submit" name="submit_form" id="editer_ajouter" class="btn btn-dark mb-3" >Valider</button>


            </form>

        </div>

    </div>

</div>




