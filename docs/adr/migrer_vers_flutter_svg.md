# Migrer vers flutter_svg

## Date de décision

3 avril 2025

## Statut

Rejeté

## Contexte

Migrer de jovial_svg vers flutter_svg pour réduire nos dépendences car flutter_svg est utilsé par gpt_markdown

## Décision

J'ai essayé de migrer. Il y a un soucis où certains SVGs sont déssiné hors limit.

## Conséquences

Le [soucis](https://github.com/flutter/flutter/issues/160589) vient de flutter, mais jovial_svg doit mieux le gérer.
