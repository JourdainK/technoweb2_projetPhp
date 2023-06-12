<?php
session_start();
$prods = new produits($cnx);
$produits = $prods->getAllProduits();
//var_dump($produits);
$cnt = count($produits);
//print 'count : '.$cnt;

?>

<div class="container pt-5">
    <br><br>


    <div class="row">
        <div class="col-8">
            <div class="row text-light text-center justify-content-center">
                <div class="row text-light text-center justify-content-center m-3">

                    <a href="./pages/testMPDF.php" target="_blank"
                       class="align-self-right text-right btn btn-dark text-light" role="button" alt="créér pdf produits">Télécharger
                        le catalogue</a>
                </div>
                <h3>Dvd</h3>
                <?php
                for ($i = 0; $i < $cnt; $i++) {
                    if ($produits[$i]->id_categorie == 1) {
                        ?>

                        <div class="card mb-3 p-2 m-3" style="max-width: 400px;">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="../<?php print $produits[$i]->photo; ?>" class="img-fluid rounded-start" alt="..." style="max-width: 150px;">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title text-black"><?php print $produits[$i]->nom_produit; ?></h5>
                                        <p class="card-text text-black">Prix : <?php print $produits[$i]->prix; ?> €</p>
                                        <p class="card-text"><small
                                                    class="text-muted"><?php print $produits[$i]->description; ?></small>
                                        </p>
                                        <button type="button" class="btn btn-primary btn-sm">Ajouter</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <?php
                    }
                }
                ?>


            </div>

            <div class="row text-light text-center justify-content-center">
                <h3>Livres</h3>
                <?php
                for ($i = 0; $i < $cnt; $i++) {
                    if ($produits[$i]->id_categorie == 2) {

                        ?>

                        <div class="card mb-3 p-2 m-3 mx-auto" style="max-width: 400px;">
                            <div class="col g-0">
                                <div class="row-md-2 ">
                                    <img src="../<?php print $produits[$i]->photo; ?>" class="img-fluid rounded-start"
                                         alt="..." style="max-width: 180px;">
                                </div>
                                <div class="row-md-10">
                                    <div class="card-body">
                                        <h5 class="card-title text-black"><?php print $produits[$i]->nom_produit; ?></h5>
                                        <p class="card-text text-black">Prix : <?php print $produits[$i]->prix; ?> €</p>
                                        <button id="book<?php print $produits[$i]->id_produit; ?>but" type="button"
                                                class="btn btn-primary btn-sm">Description
                                        </button>
                                        <p id="book<?php print $produits[$i]->id_produit; ?>" class="card-text"><small
                                                    class="text-muted"><?php print $produits[$i]->description; ?></small>
                                        </p>
                                        <br><br>
                                        <button type="button" class="btn btn-primary btn-sm">Ajouter</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <?php
                    }
                }
                ?>
            </div>

            <div class="row text-light text-center justify-content-center">
                <h3>Goodies</h3>
                <?php
                for ($i = 0; $i < $cnt; $i++) {
                    if ($produits[$i]->id_categorie == 3) {

                        ?>

                        <div class="card mb-3 p-2 m-3" style="max-width: 400px;">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="../<?php print $produits[$i]->photo; ?>" class="img-fluid rounded-start"
                                         alt="...">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title text-black"><?php print $produits[$i]->nom_produit; ?></h5>
                                        <p class="card-text text-black">Prix : <?php print $produits[$i]->prix; ?> €</p>
                                        <p class="card-text"><small
                                                    class="text-muted"><?php print $produits[$i]->description; ?></small>
                                        </p>
                                        <button type="button" class="btn btn-primary btn-sm">Ajouter</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <?php
                    }
                }
                ?>
            </div>

        </div>

        <div class="col">
            <div class="panier">


                <?php
                if (!empty($_SESSION["shopping_cart"])) {
                    $cart_count = count(array_keys($_SESSION["shopping_cart"]));
                    ?>
                    <div class="cart_div">
                        <h3>Panier d'achat</h3>
                        <a href="prod.php" id="panier">
                            <img id="CartIcon" src="cart-icon.png"/>
                            <button id="panierBut">Panier/Checkout<br></button>
                        </a> <br><br>
                        <p id="cartCount"><?php echo $cart_count . '(Produit(s))'; ?></p>


                    </div>

                    <img title="Carlin showing up" id="UP" src="images/up.jpg">

                    <?php
                }
                ?>


            </div>
        </div>

    </div>


</div>

