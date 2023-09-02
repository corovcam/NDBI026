## TODO

-  Program.Name by asi měl být UNIQUE. Obecně bývají entity v realitě
odlišitelné, a tak by se to mělo promítnout i do schématu. ID je umělé a
s realitou nic společného nemá.

- Přijde mi, že komentář u  FK Teaches.teacher_id ON DELETE NO ACTION
neodpovídá této klauzuli. Pokud se mají informace zachovat, i když
smažete učitele, asi by tam mělo být SET NULL.

- I když u ON DELETE dáváte NO ACTION, asi by nic nebránilo u ON UPDATE
mít CASCADE. Na druhou stranu jsou klíče generované přes IDENTIY, a tak
se měnit nebudou.

- Je PK u Course_Schedule v tomto pořadí ideální? Spíše budu asi hledat,
kdy přesně začínají paralelky konkrétního předmětu v pondělí, než ve
které dny začínají paralelky konkrétního předmětu od 15:40.

- Když je Teacher.teacher_id PK té tabulky, proč se nad ním ještě
vytváří obyčejný index? PK vytvoří sám o sobě index unikátní.

- Podobně např. PK přes Enrollment umožňuje efektivní hledání přes jeden
z cizích klíčů. Stačí Vám tedy jen index přes ten druhý.