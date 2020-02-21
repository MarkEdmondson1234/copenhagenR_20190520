library(googleCloudRunner)

# deploy plumber API via gadget, get the URL
"../demos/cloudstorage-plumb/api/"

# (or deploy via)
# cr_deploy_plumber("../demos/cloudstorage-plumb/api", image_name = "gcs-pubsub")

# setup pub/sub topic to output to Cloud Run URL
# https://console.cloud.google.com/cloudpubsub/subscription/list?project=mark-edmondson-gde

cr_pubsub("https://api-ewjogewawq-ew.a.run.app/pubsub",
          jsonlite::toJSON(list(name = "test_file_from_r")))

# test by adding file to bucket
googleCloudStorageR::gcs_upload(mtcars, bucket = "mark-edmondson-public-files")

