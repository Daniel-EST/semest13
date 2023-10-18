port <- 4445L

geckodriver <- wdman::selenium(port = port, verbose = FALSE)

rem_dr <- RSelenium::remoteDriver(
  remoteServerAddr = "localhost",
  port = port,
  browserName = "firefox"
)

rem_dr$open()
rem_dr$navigate("https://www.airbnb.com.br")

local = rem_dr$findElement('css selector','#bigsearch-query-location-input')
local$sendKeysToElement(list("rio de janeiro", key = "enter"))
buscar = rem_dr$findElement(using="xpath",'//*[@class="t1dqvypu dir dir-ltr"]')
buscar$clickElement()

DF = tibble::tibble(NOME = character(),URL = character(),PRECO = character())

qtd_paginas = rem_dr$findElement('xpath','/html/body/div[5]/div/div/div[1]/div/div[2]/div[2]/main/div[2]/div/div[3]/div/div/div/nav/div/a[4]')$getElementText()
qtd_paginas = as.integer(qtd_paginas) 

for(i in 2:qtd_paginas){
  print(paste0("Página: ",i))
  
  quartos = rem_dr$findElements('xpath', '//*[@class="c1l1h97y dir dir-ltr"]')
  for(quarto in quartos){
    quarto$clickElement()
    janelas = rem_dr$getWindowHandles()
    rem_dr$switchToWindow(janelas[[2]])
    Sys.sleep(3)
    
    nome = rem_dr$findElement('xpath','//h1')
    nome = nome$getElementText()
    print(nome[[1]])
    
    url = rem_dr$getCurrentUrl()
    
    preco = rem_dr$findElement('css selector','._1qs94rc > span:nth-child(1) > span')
    preco = preco$getElementText()
    
    DF = DF |> tibble::add_row(NOME = nome[[1]],
                               URL = url[[1]],
                               PRECO = preco[[1]])
  
    rem_dr$closeWindow()
    rem_dr$switchToWindow(janelas[[1]])
  }
  proxima = rem_dr$findElement('xpath','//a[@aria-label="Próximo"]')
  proxima$clickElement()
  Sys.sleep(3)
}

write.csv(DF,"../../data/rselenium/acomodacoes.txt")

rem_dr$close()
geckodriver$stop()
