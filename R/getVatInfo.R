#' Validates any given vat number and returns its validity and company information
#' @param vat_number (required)	The vat number you want to query (Either: including the country prefix, or without and you specify the country_code)
#' @param country_code An ISO Alpha 2 Country Code for the vat number (e.g. LU)

#' @return Returns all available information about the VAT ID.
#' @export


get_vat_info <- function(vat_number, country_code = NULL) {

  # check for API key or ask for API key
  apikey <- vatcheckapi_api_key()

  # ensure necessary packages are installed
  if (!requireNamespace("httr", quietly = TRUE)) {
    stop("Please install the 'httr' package to use this function.")
  }
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Please install the 'jsonlite' package to use this function.")
  }

  # define the API URL
  api_url <- "https://api.vatcheckapi.com/v2/check"

  # generate query
  params <- list(apikey = apikey, vat_number = vat_number)

  # append params to query if not null

  if(!is.null(country_code)) {
    params['country_code'] <- country_code
  }

  # make the API request
  response <- httr::GET(api_url, query = params)

  # check if the request was successful
  data <- success_check(response)

  data <- jsonlite::fromJSON(httr::content(response, as = 'text' ,type = 'application/json', encoding="UTF-8"), flatten = TRUE)

  # return the result
  return(data)
}
