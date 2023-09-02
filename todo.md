## TODO

-  Program.Name by asi měl být UNIQUE. Obecně bývají entity v realitě
odlišitelné, a tak by se to mělo promítnout i do schématu. ID je umělé a
s realitou nic společného nemá.
   - Áno je to tak, zrušil som Index a vytvoril UNIQUE constraint. 
   - Commit: https://github.com/corovcam/NDBI026/commit/b80fb1b8d07df706bcd5eb4c33aedf59f8f7e05c

- Přijde mi, že komentář u FK Teaches.teacher_id ON DELETE NO ACTION
neodpovídá této klauzuli. Pokud se mají informace zachovat, i když
smažete učitele, asi by tam mělo být SET NULL.
    - Áno, problém bol, že som mal teacher_id súčasťou PK, takže som to nemohol nastaviť na NULL (bez zmeny pôvodného composite PK a vytvorenia novégo). Nastavil som to teda na ON DELETE CASCADE a popísal v komentári. Tak isto som prepísal aj Enrollment.
    - Commit: https://github.com/corovcam/NDBI026/commit/99d000d1a86470f030fbce071e5cdd8767805bd1

- I když u ON DELETE dáváte NO ACTION, asi by nic nebránilo u ON UPDATE
mít CASCADE. Na druhou stranu jsou klíče generované přes IDENTIY, a tak
se měnit nebudou.
    - Kľúče sa nikdy meniť nebudú a všetky tabuľky, ktoré (aj tranzitívne) referencujú Person(person_id) majú ON UPDATE NO ACTION ON DELETE NO ACTION, keďže Person entity by sa nemala mazať. (až na výnimky, ktoré sú v komentári)
    - Commit: https://github.com/corovcam/NDBI026/commit/99d000d1a86470f030fbce071e5cdd8767805bd1

- Je PK u Course_Schedule v tomto pořadí ideální? Spíše budu asi hledat,
kdy přesně začínají paralelky konkrétního předmětu v pondělí, než ve
které dny začínají paralelky konkrétního předmětu od 15:40.
    - Zmenil som to na: (course_id, day_of_week, start_time, end_time).
    - Commit: https://github.com/corovcam/NDBI026/commit/75fcbe3dd14b549c9865705bebc15a5b8554da57

- Když je Teacher.teacher_id PK té tabulky, proč se nad ním ještě
vytváří obyčejný index? PK vytvoří sám o sobě index unikátní.
    - Commit: https://github.com/corovcam/NDBI026/commit/ad15f58a13d9ff4948512fcc82d42d2a37ee845a

- Podobně např. PK přes Enrollment umožňuje efektivní hledání přes jeden
z cizích klíčů. Stačí Vám tedy jen index přes ten druhý.
    - Commit: https://github.com/corovcam/NDBI026/commit/ad15f58a13d9ff4948512fcc82d42d2a37ee845a
  