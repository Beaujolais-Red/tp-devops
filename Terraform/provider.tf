terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "4.1.0"
    }
  }
}

provider "heroku" {
	email =  var.heroku_email
	api_key = var.heroku_api_key
}

resource "heroku_app" "tp_devops_prod" {
  name   = "tp-wsf-prod"
  region = "eu"
  }

resource "heroku_addon" "devops_db_production" {
  app  = heroku_app.tp_devops_prod.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "tp_devops_staging" {
  name   = "tp-wsf-staging"
  region = "eu"
  }

resource "heroku_addon" "devops_db_staging" {
  app  = heroku_app.tp_devops_staging.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "tp_devops_qa" {
  name   = "tp-wsf-qa"
  region = "eu"
  }

resource "heroku_addon" "devops_db_qa" {
  app  = heroku_app.tp_devops_qa.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_pipeline" "pipeline_tp" { #On peut remplacer pipeline par n'importe quel nom mais il faut le changer pour coupler après aussi
  name = "supertanker-enncore-plus-gros"
}

resource "heroku_pipeline_coupling" "coupling_staging" {
  app      = heroku_app.tp_devops_staging.name
  pipeline = heroku_pipeline.pipeline_tp.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "coupling_production" {
  app      = heroku_app.tp_devops_prod.name
  pipeline = heroku_pipeline.pipeline_tp.id
  stage    = "production"
}

resource "heroku_pipeline_coupling" "coupling_qa" {
  app      = heroku_app.tp_devops_qa.name
  pipeline = heroku_pipeline.pipeline_tp.id
  stage    = "staging"
}