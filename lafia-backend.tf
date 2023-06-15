resource "kubernetes_secret" "lafia_backend_secret" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
  ]
  metadata {
    name = "lafia-backend-secret"
    namespace = "staging"
  }

  data = {
    POSTGRES_PASSWORD = "QVZOU194aWEwUEx1Y1pkUVhvTElOOW4z"
    POSTGRES_USER     = "ZG9hZG1pbg=="
    AWS_ACCESS_KEY_ID  = "QUtJQVVBVEpMWjZUUFNIS0ozNk0="
    AWS_SECRET_ACCESS_KEY = "U2gvMzlBbFZJbStMNnRmNnFUWkloWkZxODlBdHB0WkpBbDhjanF6aQ=="
    JWT_SECRETE_KEY = "dGlzVGhkbzMyMjkzaWRoaWZpanQzMTBfOTNpaWpfM3U="
    PLATFORM_ADMIN_KEY = "MzkzNTA0NzM0MjM4"
    REDIS_PASSWORD = "VzJDbzV4MjdMZmpyTW1LTTg3elZvZG9IUWFmaUhhN1Y="
    TWILIO_AUTH_TOKEN = "Mjg5NjE2Zjk5YzYwMzYxN2Q4MDUzYjQ1MGFhNGUzMmM="
    TWILIO_API_KEY = "U0tiNGE5NTVkZGMzNmNjZjQyZTYxMjM0YjFiY2QwMDcyMA=="
    TWILIO_API_SECRET = "UXJKemhlYzdzOTJNZE9uM1hvRGpHZm5GNVVpNFZpYjI="
    EMAIL_PASSWORD = "b2l0ZHhqYWZyY21jeWRjbQ=="
    SAFHIR_CLIENT_SECRET = "ODZPdGR2ZDRnU3UxZDhUUXRBUl9fNzI5b0FlemFTVC10LQ=="
    CONSENT_SERVICE_AUTH_CODE = "ODA0YzcxMTYtMGZlNi00ZmVmLWE2YmQtMjJlZDUwMGZkZGM2"
    PORT = 9500
    NODE_ENV= "staging"
    POSTGRES_PORT= 25060
    POSTGRES_HOST= "db-postgresql-nyc1-12259-do-user-3558509-0.b.db.ondigitalocean.com"
    POSTGRES_DBNAME= "lafiadb"
    DATABASE_SSL= "true"
    DATABASE_CA= "-----BEGIN CERTIFICATE-----MIIEQTCCAqmgAwIBAgIUCQjR71AvUIoPWPrz0hKpv/u8/nkwDQYJKoZIhvcNAQEMBQAwOjE4MDYGA1UEAwwvOTAzYzBhMjQtZjMwMS00MzYyLThhYTMtZDQ4ZGE0ZjY0NTU5IFByb2plY3QgQ0EwHhcNMjExMDIxMTIxMDExWhcNMzExMDE5MTIxMDExWjA6MTgwNgYDVQQDDC85MDNjMGEyNC1mMzAxLTQzNjItOGFhMy1kNDhkYTRmNjQ1NTkgUHJvamVjdCBDQTCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAPOMZ6s91sCc2BO4eZ69zYSms6zoUJ6tySq9lVMYujMpYAbjxVHlS4Fg67qsr80LYIxC4j+xF7UhzZGJVaZD4ZZFrus6vu1UxwB368fVAaS3dv1mqZb5o/PzDHABEJrkghQn28DJS26qY3xuQNC2BvhszCitsqwrjh+kUJKGWmrWHW94C07QeXHFCrgcjA1bAWtTzj3QNUuRObE1PXenUq+MLP3Og614I6bGuFoTOWH7b+RbM79cK/yvkRT4np8bmpCTh67SdlJk9Yj84vPBwSJEA5lS5VjziumQyHpJC9WgpifeSWS05Gi9pzq13AkQF2CsvIV4FHCoAPGO8vurBKU5HACo0Nh5Ukg+4nsMLUOBBxGx/HfV9F0JO4YIYjfqSe7vVMHpSu2LWXWu8a0TUBWEPG6P1AdtKmnl6sEn6JcHqm5hBtOqd3kQN7ABsuZhBnCHjnHPO2PvD3ToXebfLmEXyo27Ykby+KCo0mq6CauCcaEv7MjKdrcOo4UJwUTlzwIDAQABoz8wPTAdBgNVHQ4EFgQU3HGCZ/IiHh+AQb7WOTs1YEFLBBwwDwYDVR0TBAgwBgEB/wIBADALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEMBQADggGBAFPwE3Wb7LrBlR6JO8ujwZ5H91yNCSow0tjWIkB5IbmTysn3ZY3WbD5YXqIv1zxUkvaU47nnIvCO6LCVyuDd/5Zd1B2Lve0mlePT4UJB3gftsN8XGtIU21kCqSskU9pTLBsMtziAhu9GF/9ZNCS4LUgfafIJefjwywTxPePaZWe4HsEBHE1X3UgtrbAYZQRDzRpZGb6DSOKkuYoxtP/hUJ3lg+b9es4SFnkZCqpvaApPhy/3NWNFmdMzlzMCZ/nfjL6woDppTSAwKNEYK1btu/XSJYdaeX648wNb1qE6mh6UUCK3VYY67Dqw7XHRafKQdse/IwdBgV4Pu3ToyaQJUnW/KER3ZT40W/HsNQmaetm0yCdVrxakNLrIvhx50VByy1pK28n39yHtXpcwksnm5OXouHkl+vmw2sTsTbz4xGLgOhDVarohzOTyY/kkK3uHfGtCo+p8LdXqAxoSpxryRfIlZOjPW94LpjrDm8iITPOyZpnrKZOJNuPOeNDNgq6GJw==-----END CERTIFICATE-----"
    FIREBASE_PRIVATE_KEY= "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDYBidgeYEM9vge\nB9ZtVQ8Z4Rp0Q0OaOeKn49b5VPuv4pswmFu4S2LmRoSgsYidMpwzHMtNUMWLh3nd\nMukAOljdsXTl2Yt6D1Om8FhWtOfhEq5oaR6YlYdmXsFAa7t0nMcbdpz8ekfMLbIv\nzxot6JTs8txUeJtDZVGtblK+sSI7obp1sCafzopK286E6q6YwUzB6B9X+jvQoqnz\nYbJw55kESAIejmHnqBuHt3VAsY18yyFNRlmlqbZ+VQR2BpEIwtu+ZxbNXg79/8YW\nD8Ir6o4zEjMVW4vOZqrJDPFGD0LRw0JVBSpuJtiCOA3Zx6JIi6Y3MABPLfnxJQpu\ng1A6OklhAgMBAAECggEAA2afZpOrHjDiKZjefZSl+vaSA8wOS6aHJLT/zKeTmcqD\nvnFbmkxnh3ALRPtehvkFwAE/Sx2PKpnsp3iWdfg1L3JMgJTa7wZAPyPQBDdvYhn4\n8HBdOLI78jbiLHk1t4mDUfGdWZU0Pajngfys8RWVCKDvKo5GhXpaHZSbzWA9BXrI\nLHShTeZm6aCOYp11KwDe1uzQxCLdIv6UfhsFbeB4Z/iTyzkWPAMysCbRjJohGcdS\nr6qBe0naOEkcGmwJR8/GfSgA7jBqWgIik7W9HmnFOfMvd7GFQMsCWErcRZ0CJ/qp\nSFcjT4km/ILN/cxBL2G3+san+yNLoSJ5mFQAwejpVQKBgQDwUIkFUmvaA8O03C1L\nGcj77TwsprZF919PNNeCd+KxmgQlpbySSOLriB1gO6gUW/qkne+q8EHiMqvla7dq\nursvq7UL2aQFW0cT9cDuQi2d972aD6N+Y1/iU+k9gdpdvAp2RoiGvoDisg1rEB8X\n4hw/z3KkGF3j832pb4BpRaGj7QKBgQDmH74sBq55b3vXnbzCmTMJHLZyHXn7tvft\nteoEFJXsVH8YwM35xrwUzentdsG3Lnrkxl3HgoULKIgWKXnWoiEnd/5BvT14YQjR\nbZTnGtTo24PirsFO6BO2lHnYvj6BOAINX9Qggq9yBRGDUBRamlEKGumGMqZ1iQKx\nX+DzQlc0xQKBgQDV4GdCZEt2mfkYwwhQmZ9Fj6sJdkos1O9vV/Ehvb71H8TnGK1O\naC4FP3wdhJqfnAjjb2i5cuDABybzpT11cMFduO0FoeqXldgZjJPruNxOhgmpzpdM\nyfaxQMsJocMNv2h0QWwKuAuPNrY4ff2eTO+lXuSB5OnTEYbaQFFB3+XvNQKBgBew\n7ugja/TuiEZjY9p44Ssv/Ix1Amjqpk2fq87tu52P+WG3/7yWPCi8JjgfQMQ2EcrZ\nrS/r/PxwGMqHTJbPLDCfBtsHu3tYKgs9h9XfCkpKxyIgMaCI/faPBJhOxaqR9Iwh\n8HnEWoGXif0F0oKdXnh22tHJByAUkeVm5IbGrqmtAoGAbVq02AKy4h9Et9sh4At+\nSt9ln1ND+ENRxECxt5V8PKFB0LKx6LzvA/NTZUZZeNKNmIZEo0beuJl9dkt+VmdA\nU6vFn2lKA64n85r3WeoAyhzc3eggG35A9MOg4jq7y4BRyLcbTXvjnxkhky6TMtLL\nkONNlV0ohd+5AYbTjzwr+Wo=\n-----END PRIVATE KEY-----"
    FIREBASE_CLIENT_EMAIL= "firebase-adminsdk-o22gg@lafia-service-dev.iam.gserviceaccount.com"
    FIREBASE_PROJECT_ID= "lafia-service-dev"
    FIREBASE_DATABASE_URL= "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-o22gg%40lafia-service-dev.iam.gserviceaccount.com"
    RABBITMQ_CONNECTION= "amqps://ntortjez:PprSGbMP70ortTbSO6KY_ZFXfp-5HSKX@possum.lmq.cloudamqp.com/ntortjez"
    RABBITMQ_PUB_QUEUE= "staging-resourcesCreated"
    RABBITMQ_SUB_QUEUE= "staging-createResources"
    AWS_REGION= "us-east-1"
    AWS_BUCKET= "lafia-media-bucket"
    PLATFORM_APP_NAMESPACE= "lafia-service"
    REDIS_PORT= 10371
    REDIS_HOST= "redis-10371.c8.us-east-1-3.ec2.cloud.redislabs.com"
    REDIS_USERNAME= "default"
    TWILIO_ACCOUNT_SID= "AC8cde7d14a12afcacef7e31aec0bd6336"
    TWILIO_VERIFY_SID= "VAadd5f93e750d9172f30d73c7f0ea9ff1"
    TWILIO_COMPOSITION_CALLBACK= "https://lafia-backend-service.parallelscoreprojects.com/media/events"
    EMAIL_HOST= "smtp.gmail.com"
    EMAIL_ADDRESS= "lafiadevteam001@gmail.com"
    EMAIL_PORT= 456
    FHIR_SERVER_BASE_URL= "https://fhir-server.parallelscoreprojects.com/fhir"
    LAFIA_MEDIA_URL= "https://ant-media.parallelscoreprojects.com/WebRTCAppEE"
    LAFIA_RTMP_URL= "rtmp://ant-media.parallelscoreprojects.com/WebRTCAppEE"
    CONSENT_SERVICE_BASE_URL= "http://54.198.118.116:7727/consent-api/v1"
    SAFHIR_AUTHORIZATION_URL= "https://api-dmdh-t31.safhir.io/v1/authorize?aud=https://api-dmdh-t31.safhir.io/v1"
    SAFHIR_SCOPE= "launch/patient fhirUser openid offline_access"
    SAFHIR_CLIENT_ID= "c1317a46-a048-4402-a181-2221fac4fc99"
    SAFHIR_TOKEN_URL= "https://oysfdmdht31tenantb2c.b2clogin.com/oysfdmdht31tenantb2c.onmicrosoft.com/B2C_1A_DMDH_T31_V1_SIGNUP_SIGNIN/oauth2/v2.0/token"
    SAFHIR_CALLBACK_URL= "https://api.lafia.io/safhir"
    SAFHIR_BASE_URL= "https://api-dmdh-t31.safhir.io/v1/api"
    CMS_URL = "http://lafiacms.parallelscoreprojects.com/api/content"
    SURESALAMA_URL = "https://suresalama-backend.parallelscoreprojects.com"
    }

  type = "Opaque"
}

resource "kubernetes_deployment" "lafia-backend" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
  ]

  metadata {
    name = "lafia-backend"
    labels = {
      App = "lafia-backend"
    }
    namespace = "staging"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "lafia-backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "lafia-backend"
        }
      }
      spec {
        container {
          image = "parallelscore/lafia-backend:latest"
          name  = "lafia-backend"

          image_pull_policy = "Always"

          env_from {
            secret_ref {
              name = kubernetes_secret.lafia_backend_secret.metadata.0.name
            }
          }  

          port {
            container_port = 9500
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.lafia_backend_secret.metadata.0.name
            }
          }

          resources {
            limits = {
              cpu    = "512m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "250Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "lafia_service" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging, kubernetes_deployment.lafia-backend
  ]

  metadata {
    name      = "lafia-backend"
    namespace = "staging"
  }
  spec {
    
    selector = {
      App = kubernetes_deployment.lafia-backend.spec.0.template.0.metadata[0].labels.App #kubernetes_deployment.videomerger.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 9500
    }
     type = "ClusterIP" #"ClusterIP" #type = "LoadBalancer"
  }
}