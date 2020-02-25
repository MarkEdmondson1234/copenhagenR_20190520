library(googleCloudRunner)

rmd_build <- cr_build_yaml(
  steps = c(
    cr_buildstep(
      "gsutil",
      args = c("cp",
               "gs://mark-edmondson-public-read/scheduled_rmarkdown.Rmd",
               "scheduled_rmarkdown.Rmd")),
    cr_buildstep_r(
      "gcr.io/gcer-public/render_rmd:master",
      r = "rmarkdown::render('scheduled_rmarkdown.Rmd',
               output_file = 'scheduled_rmarkdown_2020.html')",
  )),
  artifacts = cr_build_yaml_artifact(
    "scheduled_rmarkdown_2020.html",
    bucket = "mark-edmondson-public-read")
)

# see the cloudbuild.yml
rmd_build

# test the build
built <- cr_build(rmd_build)

# should create a public URL
# https://storage.googleapis.com/mark-edmondson-public-read/scheduled_rmarkdown_2020.html

# schedule the build
cr_schedule("rmd-demo", schedule = "15 5 * * *",
            httpTarget = cr_build_schedule_http(built))
