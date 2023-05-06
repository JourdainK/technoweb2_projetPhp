<?php

class produits extends Hydrate {
    private $_db; //recevra $cnx de l'index
    private $_array = array(); //retourner le result set

    public function __construct($cnx){
        $this->_db = $cnx;
        //var_dump($cnx);
    }

    public function getAllProduits(){
        try{
            $query = "SELECT * FROM produit ORDER BY id_produit";
            $res = $this->_db->prepare($query);
            $res->execute();
            while($data = $res->fetch()){
                $_array[]=new Hydrate($data);
            }
            if(empty($_array)){
                return null;
            }
            else{
                return $_array;
            }
        }
        catch(PDOException $e){
            echo '<br>Echec de la connexion : '.$e->getMessage();
        }
    }

    public function updateProduit($champ,$valeur,$id_produit){
        try {
            $query = "update produit set ".$champ." = :valeur WHERE id_produit= :id_produit";
            $res = $this->_db->prepare($query);
            $res->bindValue(':valeur',$valeur);
            $res->bindValue(':id_produit',$id_produit);
            $res->execute();
        }catch (PDOException $e){
            print 'Echec'.$e->getMessage();
        }
    }

    //Spécial ajax
    public function getProdByNom($nom){
        try{
            $query="select * from produit where nom_produit = :nom";
            $res = $this->_db->prepare($query);
            $res->bindValue(':nom',$nom);
            $res->execute();
            $data = $res->fetch();
            if(!empty($data)) {
                return $data;
            }
            else{
                return 0;
            }
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function deleteProd($id_produit){
        try{
            $query = "DELETE FROM produit where id_produit= :id_produit";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_produit',$id_produit);
            $res->execute();

        }catch(PDOException $e) {
            print "Echec ".$e->getMessage();
        }
    }


    public function addProd($nom_produit, $description, $prix, $id_categorie){
        try{
            $query = "INSERT INTO produit (nom_produit, description, prix, id_categorie) values";
            $query.="('".$nom_produit."','".$description."','".$prix."', '".$id_categorie."')";

            $res = $this->_db->prepare($query);
            $res->execute();
        }catch (PDOException $e){
            print "Echec".$e->getMessage();
        }

    }

    //essaie upload photo php => incompatibilité , AJAX/PHP => rechercher tuto ajax/upload php
    public function addPhoto($photoPath, $nomProd) {
        try {
            $query = "UPDATE produit SET photo=:photoPath WHERE nom_produit=:nomProd";
            $res = $this->_db->prepare($query);
            $res->bindValue(':photoPath',$photoPath);
            $res->bindValue(':nomProd',$nomProd);
            $res->execute();
        } catch (PDOException $e) {
            print "Échec : ".$e->getMessage();
        }
    }


}
