# Projet Action

Ce projet contient une application Flask simple, une configuration Kubernetes, et une configuration Terraform pour déployer sur AWS EC2.

## Déploiement sur AWS avec Terraform

### Prérequis

1.  **Compte AWS** : Vous devez avoir un compte AWS actif.
2.  **Bucket S3 pour le State Terraform** :
    *   Le workflow GitHub Actions se charge automatiquement de créer le bucket S3 pour stocker l'état Terraform s'il n'existe pas.
    *   Le nom du bucket est configuré dans `terraform/main.tf` et le workflow CI (actuellement : `terraform-state-projet-action-shiroiryu753-v2`).
    *   Région : `us-east-1` (N. Virginia).

### Configuration GitHub Actions

Pour que le workflow de déploiement Terraform fonctionne, vous devez ajouter les secrets suivants dans votre dépôt GitHub (Settings > Secrets and variables > Actions) :

*   `AWS_ACCESS_KEY_ID` : Votre clé d'accès AWS.
*   `AWS_SECRET_ACCESS_KEY` : Votre clé secrète AWS.
*   `AWS_SESSION_TOKEN` : Votre token de session AWS (nécessaire pour les comptes temporaires/académiques).
*   `DOCKERHUB_USERNAME` : Votre nom d'utilisateur Docker Hub.
*   `DOCKERHUB_TOKEN` : Votre token d'accès Docker Hub.

### Fonctionnement

*   Le code de l'infrastructure se trouve dans le dossier `terraform/`.
*   Le workflow GitHub Actions `.github/workflows/ci.yml` gère à la fois le build Docker, la mise à jour des manifestes Kubernetes, et le provisionnement de l'infrastructure Terraform.
*   Il provisionne une instance EC2 `t2.micro` (éligible à l'offre gratuite).
*   L'instance EC2 installe Docker et lance automatiquement la dernière version de l'image Docker de l'application.

### Accès à l'application

Une fois le déploiement terminé, l'adresse IP publique de l'instance sera affichée dans les logs de l'étape "Terraform Apply" du job `terraform` dans le workflow GitHub Actions. L'application est accessible sur le port 80 (HTTP standard).

Exemple : `http://34.201.12.34`

## Destruction de l'infrastructure

Pour détruire l'infrastructure et le bucket S3 de state :

1.  Allez dans l'onglet **Actions** de votre dépôt GitHub.
2.  Sélectionnez le workflow **Destroy Infrastructure** dans la barre latérale gauche.
3.  Cliquez sur le bouton **Run workflow**.

Ce workflow va :
1.  Détruire les ressources AWS créées par Terraform (EC2, Security Group, etc.).
2.  Une fois la destruction réussie, supprimer le bucket S3 contenant le state Terraform.
