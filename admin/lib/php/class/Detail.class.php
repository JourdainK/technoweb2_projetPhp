<?php
class Detail extends Hydrate {
    private $_db;
    private $data = array();
    private $result;

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }


    public function addDetail($id_detail, $quantite, $id_commande, $id_produit){
        try {
            $query = "INSERT INTO detail(id_detail, quantite, id_commande, id_produit) VALUES (:id_detail, :quantite, :id_commande, :id_produit)";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_detail', $id_detail);
            $res->bindValue(':quantite', $quantite);
            $res->bindValue(':id_commande', $id_commande);
            $res->bindValue(':id_produit', $id_produit);

            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return $data;
            }
            else{
                return null;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }


    public function removeDetail($id_detail){
        try {
            $query = "DELETE FROM detail WHERE id_detail = :id_detail";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_detail', $id_detail);
            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return $data;
            }
            else{
                return null;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }


}
