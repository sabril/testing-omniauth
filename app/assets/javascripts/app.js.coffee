jQuery ->

  $("a.popup").click (event) ->
    event.preventDefault()

    url    = $(this).attr("href")
    name   = $(this).attr("title")  or $(this).data("title") or ""
    width  = $(this).data("width")  or 600
    height = $(this).data("height") or 400
    left   = $(this).data("left")   or ((screen.width  / 2) - (width  / 2))
    top    = $(this).data("top")    or ((screen.height / 2) - (height / 2))

    window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top)
