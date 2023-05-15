test_that("VAT info check works", {

  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()

  x <- get_vat_info("LU26375245")

  expect_equal(class(x), "list")
  expect_equal(x$vat_number, "26375245")

})
