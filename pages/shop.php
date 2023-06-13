<?php
$prods = new produits($cnx);
$produits = $prods->getAllProduits();
//var_dump($produits);
$cnt = count($produits);
//print 'count : '.$cnt;

// Check if the add to cart form is submitted
if (isset($_POST['add_to_cart'])) {

    $product_id = $_POST['product_code'];
    $qty = $_POST['quantity'];


    // Check if the shopping cart session variable is not already set
    if (!isset($_SESSION['shopping_cart'])) {
        $_SESSION['shopping_cart'] = array();
        $_SESSION['cart_quantity'] = array();
    }

    if (!in_array($product_id, $_SESSION['shopping_cart'])) {
        // Add the product to the shopping cart session variable
        $_SESSION['shopping_cart'][] = $product_id;
        $_SESSION['cart_quantity'][] = $qty;

        // Redirect to prevent form resubmission
        header("Location: " . $_SERVER['PHP_SELF']);
        exit();
    }


}

if (isset($_POST['delete_from_cart'])) {
    $product_id = $_POST['product_id'];

    // Check if the shopping cart session variable is set
    if (isset($_SESSION['shopping_cart'])) {
        // Find the index of the product in the shopping cart array
        $index = array_search($product_id, $_SESSION['shopping_cart']);

        // Remove the product from the shopping cart array
        if ($index !== false) {
            unset($_SESSION['shopping_cart'][$index]);
        }
    }

    // Redirect to prevent form resubmission
    header("Location: " . $_SERVER['PHP_SELF']);
    exit();
}


if (isset($_POST['confirm_order'])) {
    $commande = new Commande($cnx);
    $id_commande = $commande->addBlankCommande();
    $detail = new Detail($cnx);
    $cntProd = count($_SESSION['shopping_cart']);
    for($i = 0; $i < $cntProd; $i++){
        $detail->addDetail( $_SESSION['cart_quantity'][$i],$id_commande,$_SESSION['shopping_cart'][$i]);
    }
    $total = $commande->getTotalCommande($id_commande);
    $date = date('m/d/Y', time());
    $commande->addTotalDate($id_commande,$total,$date);

    if(isset($_SESSION['client_id'])){
        $check = $commande->addIdClientToOrder($id_commande,$_SESSION['client_id']);
        if($check > 0){
            //echo '<br><br><br>Client ajouté à la commande';
        }
    }

    if(isset($_SESSION['shopping_cart'])){
        unset($_SESSION['shopping_cart']);
        unset($_SESSION['cart_quantity']);
        unset($_SESSION['id_commande']);
        unset($_SESSION["total_price"]);
    }

}

/*
if (isset($_POST['cancel_order'])) {
    //not usefull -> order hasn't been created yet (need to push confirm)
    $commande = new Commande($cnx);
    $detail = new Detail($cnx);
    $detail->removeAllDetailsOrder($id_commande);

    $commande->deleteCommande($_POST['id_commande']);
}
*/

?>




<div class="container pt-5">
    <br><br>

    <div class="row">
        <div class="col-8">
            <div class="row text-light text-center justify-content-center">
                <div class="row text-light text-center justify-content-center m-3">

                    <a href="./pages/testMPDF.php" target="_blank"
                       class="align-self-right text-right btn btn-dark text-light" role="button"
                       alt="créér pdf produits">Télécharger
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
                                    <img src="../<?php print $produits[$i]->photo; ?>" class="img-fluid rounded-start"
                                         alt="..." style="max-width: 150px;">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title text-black"><?php print $produits[$i]->nom_produit; ?></h5>
                                        <p class="card-text text-black">Prix : <?php print $produits[$i]->prix; ?> €</p>
                                        <p class="card-text"><small
                                                    class="text-muted"><?php print $produits[$i]->description; ?></small>
                                        </p>

                                        <form class="product-form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                                            <input type="number" name="quantity" value="1" min="1" max="100" step="1"><br>
                                            <input name="product_code" type="hidden" value="<?php echo $produits[$i]->id_produit; ?>">
                                            <button type="submit" class="btn btn-primary btn-sm" name="add_to_cart"> Ajouter </button>
                                        </form>


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
                                        <form class="product-form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                                            <input name="product_code" type="hidden" value="<?php echo $produits[$i]->id_produit; ?>">
                                            <input type="number" name="quantity" value="1" min="1" max="100" step="1"> <br>
                                            <button type="submit" class="btn btn-primary btn-sm" name="add_to_cart"> Ajouter </button>
                                        </form>

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
                                        <form class="product-form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                                            <input name="product_code" type="hidden" value="<?php echo $produits[$i]->id_produit; ?>">
                                            <input type="number" name="quantity" value="1" min="1" max="100" step="1">
                                            <button type="submit" class="btn btn-primary btn-sm" name="add_to_cart"> Ajouter </button>
                                        </form>

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
                <h3>Panier d'achat</h3>
                <?php
                if (!empty($_SESSION["shopping_cart"])) {
                    $_SESSION['total_price'] = 0;
                    $cart_count = count($_SESSION["shopping_cart"]);
                    echo '<p id="cartCount">' . $cart_count . ' Produit(s)</p>';
                    $prod = new produits($cnx);
                    // Display the products in the shopping cart
                    $cpt = 0;
                    foreach ($_SESSION["shopping_cart"] as $product_id) {
                        // Retrieve the product information based on the product ID
                        $product = $prod->getProdById($product_id);
                        $quantite = $_SESSION["cart_quantity"][$cpt];
                        $cpt++;
                        $total_article = $product['prix'] * $quantite;
                        $_SESSION['total_price'] += $total_article;
                        ?>
                        <div class="card mb-1 text-dark text-center">
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $product['nom_produit']; ?></h5>
                                <p class="card-text">Prix: <?php echo $product['prix']; ?> €</p>
                                <p>Quantité :  <?php print $quantite; ?></p>
                                <p>Sous-total: <?php print $total_article; ?> €</p>
                                <form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                                    <input type="hidden" name="product_id" value="<?php echo $product['id_produit']; ?>"/>
                                    <button type="submit" class="btn btn-primary btn-sm" name="delete_from_cart">Supprimer</button>
                                </form>
                            </div>
                        </div>

                        <?php
                        if(isset($_SESSION['total_price'])){
                            print 'Total de la commande : '.$_SESSION['total_price'].' €';
                        }
                        ?>
                        <?php
                    }
                } else {
                    echo '<p>Votre panier est vide.</p>';
                }
                ?>
            </div>


            <div class="text-center">
                <form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                    <?php
                    if(isset($_SESSION["shopping_cart"])){


                        print '
                        <p>Confirmer la commande : </p>
                    <button type="submit" class="btn btn-primary btn-sm m-2" name="confirm_order">Confirmer</button>
                    <!-- unimplemented yet
                    <button type="reset" class="btn btn-primary btn-sm m-2" name="cancel_order">Annuler</button>
                     -->
                    
                    ';

                    }

                    ?>

                </form>
            </div>
        </div>

    </div>


</div>


</div>

