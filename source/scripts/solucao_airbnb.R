port <- 4445L

geckodriver <- wdman::selenium(port = port, verbose = FALSE)

rem_dr <- RSelenium::remoteDriver(
  remoteServerAddr = "localhost",
  port = port,
  browserName = "firefox"
)

rem_dr$open()
rem_dr$navigate("https://www.airbnb.com.br")

rem_dr$findElement(using="css selector",'button.ffgcxut:nth-child(1) > div')$clickElement()
local = rem_dr$findElement('css selector','#bigsearch-query-location-input')
local$sendKeysToElement(list("rio de janeiro", key = "enter"))
buscar = rem_dr$findElement(using="css selector",'html.scrollbar-gutter.js-focus-visible.g5l85gq body.with-new-header div div div.t1bgcr6e div div div.cd56ld.cb80sj1.dir.dir-ltr div.h1ta6hky.dir.dir-ltr div.c1yo0219.dir.dir-ltr div div.dir.dir-ltr header.curo97c.c1tbb4m8.dir.dir-ltr div.c1s03i8x.c17xuogm.dir.dir-ltr div.c1ujpdn9.dir.dir-ltr div.bdypfvo.bfxfvmm.b192n4t3.b13hn6dm.dir.dir-ltr div div.ij4qtlz.dir.dir-ltr div.i1ho8jml.dir.dir-ltr form.f114qjlg.dir.dir-ltr div#search-tabpanel.cbb5b2h.c1la6dqc.dir.dir-ltr div.ir2ixub.dir.dir-ltr div.c111bvlt.c1gh7ier.dir.dir-ltr div.c1ddhymz.cggll98.dir.dir-ltr div.s1t4vwjw.dir.dir-ltr button.bhtghtc.b1tqc7mb.dir.dir-ltr span.t1ng71ne.dir.dir-ltr span.t1dqvypu.dir.dir-ltr')
buscar$clickElement()

pesquisar = rem_dr$findElement(using="css selector",'.c1nkokj4 > div:nth-child(1) > svg:nth-child(1) > path:nth-child(1)')
pesquisar$clickElement()


DF = tibble::tibble(NOME = character(),URL = character(),PRECO = character())

qtd_paginas = rem_dr$findElement('xpath','/html/body/div[5]/div/div/div[1]/div/div[2]/div[2]/main/div[2]/div/div[3]/div/div/div/nav/div/a[4]')$getElementText()
qtd_paginas = as.integer(qtd_paginas) - 1

for(i in 1:qtd_paginas){
  print(paste0("Página: ",i))
  
  quartos = rem_dr$findElements('xpath', '//*[@class="c1l1h97y dir dir-ltr"]')
  for(quarto in quartos){
    quarto$clickElement()
    janelas = rem_dr$getWindowHandles()
    rem_dr$switchToWindow(janelas[[2]])
    Sys.sleep(5)
    
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
    Sys.sleep(5)
  }
  proxima = rem_dr$findElement('xpath','//a[@aria-label="Próximo"]')
  proxima$clickElement()
  Sys.sleep(3)
}
