#import "/config.typ": theme
#import "@preview/oxifmt:0.2.1": strfmt

#set text(font: "Noto Sans Mono")

#let t = "ALGORITHMEN UND DATENSTRUKTUREN"
#let p = "DATEN"

#let substrings(p) = {
  ((p,)*p.len())
    .enumerate()
    .map(((i, s)) => s.slice(0, i+1))
    .rev()
}

#show regex(substrings(p).join("|")): highlight.with(fill: theme.success_light)

#t