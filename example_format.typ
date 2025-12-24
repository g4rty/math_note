#set text(font: "Libertinus Serif", size: 13pt)

#import "@preview/theorion:0.4.1": *
#import "@preview/showybox:2.0.4": showybox
#show: show-theorion

// --- palettes (title bar vs body) ---
#let sec_title_bg = rgb("#A0C1E5")
#let sec_body_bg = rgb("#D3E1F3")

#let pri_title_bg = rgb("#FFF799")
#let pri_body_bg = rgb("#FFFAC1")

// --- border + separator ---
#let box_border_color = rgb("#222222")
#let box_border_thickness = 0.7pt
#let header_rule_thickness = 0.6pt
#let box_radius = 3pt

#set-result("noanswer")
#set-qed-symbol[#math.qed]



// Generic renderer (used by make-frame)
#let render_showy(title_bg, body_bg, title_text_color: black) = (
  prefix: none,
  title: "",
  full-title: auto,
  body,
) => showybox(
  title: full-title,
  frame: (
    title-color: title_bg,
    body-color: body_bg,
    border-color: box_border_color,
    thickness: box_border_thickness,
    radius: box_radius,
  ),
  title-style: (
    color: title_text_color,
    weight: "bold",
    sep-thickness: header_rule_thickness, // line between header and body
  ),
  body-style: (color: black),
)[#body]

// Helper: rebuild a "secondary" env (theorem/lemma/proposition/corollary)
#let rebuild_secondary(id, counter) = make-frame(
  id,
  theorion-i18n-map.at(id),
  counter: counter,
  inherited-levels: 2,
  render: render_showy(sec_title_bg, sec_body_bg),
)

// Helper: rebuild a "primary" env (definition)
#let rebuild_primary(id, counter) = make-frame(
  id,
  theorion-i18n-map.at(id),
  counter: counter,
  inherited-levels: 2,
  render: render_showy(pri_title_bg, pri_body_bg),
)

// --- Apply ---
#let (lemma-counter, lemma-box, lemma, show-lemma) = rebuild_secondary("lemma", lemma-counter)
#show: show-lemma

#let (proposition-counter, proposition-box, proposition, show-proposition) = rebuild_secondary(
  "proposition",
  proposition-counter,
)
#show: show-proposition

#let (corollary-counter, corollary-box, corollary, show-corollary) = rebuild_secondary("corollary", corollary-counter)
#show: show-corollary

#let (theorem-counter, theorem-box, theorem, show-theorem) = rebuild_secondary("theorem", theorem-counter)
#show: show-theorem

#let (definition-counter, definition-box, definition, show-definition) = rebuild_primary(
  "definition",
  definition-counter,
)


#let ex_title_bg = rgb("#BFE3C0") // title band
#let ex_body_bg = rgb("#EAF7EB") // body
// Exercise (new environment, different color)
#let (exercise-counter, exercise-box, exercise, show-exercise) = make-frame(
  "exercise",
  "Exercise",
  inherited-levels: 2,
  render: render_showy(ex_title_bg, ex_body_bg),
)
#show: show-exercise

#set page(height: auto)
#set heading(numbering: "1.1")
#set text(lang: "en")

#set-inherited-levels(2)
#set-zero-fill(true)
#set-leading-zero(true)
#set-theorion-numbering("1.1")

= test

== sub 1
#definition(title: "test")[
  test again
]

#theorem(title: "Euclid")[
  There are infinitely many prime numbers.
]

== sub 2


#definition(title: "test")[
  test again !
]
#proposition(title: "test")[
  test prop
]

#corollary(title: "color")[
  green is green.
]

#lemma(title: "test")[
  test lemma
]

= test
== exercise

#exercise(title: "Ex2.35")[
  If $A eq.not B$ prove that $B eq.not A$
]

#exercise(title: "ex3.2")[
  The sum is:
  $ sum_(k=1)^n k = (n(n+1))/2 $

  The sum is $sum_(k=1)^n k$.
]
