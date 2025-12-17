# Projet Action

Ce projet contient une application Flask simple, une configuration Kubernetes, et une configuration Terraform pour déployer sur AWS EC2.

## Déploiement sur AWS avec Terraform

### Prérequis

1.  **Compte AWS** : Vous devez avoir un compte AWS actif.
2.  **Bucket S3 pour le State Terraform** :
    *   Le workflow GitHub Actions se charge automatiquement de créer le bucket S3 pour stocker l'état Terraform s'il n'existe pas.
    *   Le nom du bucket est configuré dans `terraform/main.tf` et le workflow CI (actuellement : `terraform-state-projet-action-shiroiryu753`).
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

Une fois le déploiement terminé, l'adresse IP publique de l'instance sera affichée dans les logs de l'étape "Terraform Apply" du job `terraform` dans le workflow GitHub Actions. L'application est accessible sur le port 5000.
