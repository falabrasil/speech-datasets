# Speech Datasets in Brazilian Portuguese :brazil:

## Index

- [Download](#download)
- [Datasets](#datasets)
    - [:earth_americas: CETUC](#cetuc): 144h
    - [:earth_americas: Constituição](#constituicao): 9h
    - [:earth_americas: Código de Defesa do Consumidor](#codigo-de-defesa-do-consumidor): TBD
    - [:earth_americas: LaPS Benchmark (LapsBM)](#laps-benchmark): 54 min
    - [:lock: LaPS Story](#laps-story): 16h
    - [:lock: Spoltech](#spoltech): 4h
    - [:lock: West Point](#west-point): 8h

### Other

- SID
- Common Voice
- Multilingual LibriSpeech

:warning: TBD


## Download

Datasets are stored on Google Drive using [DVC](https://dvc.org/). Remote
`public` is (hopefully) accessible by everyone that has a Google account to
authenticate on GDrive via DVC. Remote `private` on the other hand is, well...
private :slightly_smiling_face:.

To access the data you need to have DVC installed with Google Drive support:

```bash
$ conda create --name dvc python=3.9 --yes && conda activate dvc
(dvc) $ pip install pip -U && pip install "dvc[gdrive]"
```

Then you can use [`dvc pull`](https://dvc.org/doc/command-reference/pull) to
download the contents from the `public` remote:

```bash
$ dvc pull -r public
```

Beware this is gonna raise an error saying

```text
ERROR: failed to pull data from the cloud - Checkout failed for following targets:
...
Is your cache up to date?
```

But in the end all public datasets will already be under the `datasets` dir.
This error is probably because I didn't set a default remote. Or because DVC is
known for not handling multiple remotes well on data registries. You should see
issues 2095 on their GitHub and questions 51 174 553 and 712 on their discord
page. Someday I may copy and paste the links here. Moreover, this may also
not be the best tool for the job but at least it is a free storage.


## Datasets 

### CETUC

Seção 4.1.3 da 
[dissertação de mestrado de Rafael Oliveira (PPGCC, 2012)](https://ppgcc.propesp.ufpa.br/Disserta%C3%A7%C3%B5es_2012/Rafael%20Santana%20Oliveira_Disserta%C3%A7%C3%A3o.pdf):

> O [Centro de Estudos em Telecomunicações (CETUC)](https://www.ctc.puc-rio.br/laboratorios-cetuc),
> através do Professor Doutor Abraham Alcaim, gentilmente cedeu ao LaPS, 
> **para fins de pesquisa exclusivamente**, seu corpus de áudio para 
> Português Brasileiro. Esse corpus, é composto por áudios de 1.000 sentenças, 
> gravados por 101 locutores, totalizando aproximadamente 143 horas de áudio.

<details><summary>Stats</summary>
<p>

```text
wav  txt  size  speaker                         wav  txt  size  speaker
1000 1000 120M	cetuc/Elson_M007                1000 1000 178M	cetuc/SandraRocha_F011
1000 1000 131M	cetuc/FatimaTurano_F020         1000 1000 158M	cetuc/MarcosImbuzeiro_M036
1000 1000 182M	cetuc/FabioCorrea_M032          1000 1000 197M	cetuc/Flavia_F047
1000 1000 156M	cetuc/Jair_M021                 1000 1000 193M	cetuc/MyrzaWanderley_F051
1000 1000 171M	cetuc/FranciscoEmilio_M044      1000 1000 148M	cetuc/Nathalia_F037
1000 1000 210M	cetuc/Tulio_M027                1000 1000 147M	cetuc/AndreiaSoares_F032
1000 1000 149M	cetuc/EdsonCabral_M023          1000 1000 142M	cetuc/Anesia_F040
1000 1000 140M	cetuc/PriscilaTerra_F004        1000 1000 198M	cetuc/HenriqueMafra_M046
1000 1000 148M	cetuc/EduardoDuque_M039         1000 1000 146M	cetuc/Joel_M017
1000 1000 166M	cetuc/ConceicaoAbdulatif_F016   1000 1000 176M	cetuc/Paulinho_M000
1000 1000 238M	cetuc/Jailson_M003              1000 1000 156M	cetuc/FranciscoChagas_M034
1000 1000 134M	cetuc/Mariana_F024              1000 1000 217M	cetuc/Oswaldo_M012
1000 1000 160M	cetuc/Narhua_F029               1000 1000 144M	cetuc/Regina_F013
1000 1000 155M	cetuc/IvoneAmitrano_F000        1000 1000 124M	cetuc/CeCiliaBulcao_F021
1000 1000 167M	cetuc/EduardoPereira_M016       1000 1000 190M	cetuc/SandraCipriano_F015
1000 1000 188M	cetuc/Roseoliveira_F048         1000 1000 184M	cetuc/camillaWagner_F025
1000 1000 167M	cetuc/JonatasRibeiro_M041       1000 1000 155M	cetuc/SilvanaFerreira_F012
1000 1000 164M	cetuc/Gabriela_F034             1000 1000 170M	cetuc/Helen_F043
1000 1000 146M	cetuc/Rafael_M013               1000 1000 173M	cetuc/Ieda_F014
1000 1000 228M	cetuc/TerezaSpedo_F041          1000 1000 124M	cetuc/JulioFaustino_M005
1000 1000 182M	cetuc/DanielRibeiro_M002        1000 1000 166M	cetuc/Custodia_F033
1000 1000 213M	cetuc/jorge_M025                1000 1000 144M	cetuc/Marta_F009
1000 1000 172M	cetuc/SHEILA_F031               1000 1000 190M	cetuc/Gilberto_M018
1000 1000 149M	cetuc/Pedro_M028                1000 1000 200M	cetuc/AdrianaMalta_F049
1000 1000 155M	cetuc/TatianaRuback_F038        1000 1000 143M	cetuc/PauloSiqueira_Papus_M015
999  999  187M	cetuc/NA_F005                   1000 1000 152M	cetuc/DenizeRamos_F039
1000 1000 141M	cetuc/MarcosBittencourt_M006    1000 1000 161M	cetuc/PauloCampos_M038
1000 1000 170M	cetuc/Lila_F017                 1000 1000 161M	cetuc/Walace_M004
1000 1000 169M	cetuc/Carla_F035                1000 1000 155M	cetuc/Rose_F030
1000 1000 196M	cetuc/Andrea_F003               1000 1000 150M	cetuc/Cristiane_F007
1000 1000 131M	cetuc/Aislam_M001               1000 1000 235M	cetuc/IvanMariano_M008
1000 1000 123M	cetuc/MarioJr._M014             1000 1000 163M	cetuc/LuanaEsterLuna_F019
1000 1000 112M	cetuc/JeanCarlos_M019           1000 1000 183M	cetuc/AnaVarela_F042
1000 1000 169M	cetuc/LucasSabino9_M033         1000 1000 151M	cetuc/Alexandra_F010
1000 1000 145M	cetuc/Milena_F044               1000 1000 159M	cetuc/Patricia_F001
1000 1000 144M	cetuc/Alessandra_F045           999  999  149M	cetuc/Benita_F008
1000 1000 151M	cetuc/PedroHenrique_M045        1000 1000 131M	cetuc/RenatoPeres_M010
1000 1000 160M	cetuc/Rogerio_M035              1000 1000 195M	cetuc/Geruza_F006
1000 1000 186M	cetuc/Diego_M026                1000 1000 204M	cetuc/SallesAbi-Abib_M047
1000 1000 194M	cetuc/AnnaPerez_F046            1000 1000 155M	cetuc/Alcione_F018
1000 1000 141M	cetuc/Juliana_F028              1000 1000 163M	cetuc/CarolinaMagalhaes_F050
1000 1000 194M	cetuc/JorgeHumberto_M042        1000 1000 213M	cetuc/Jonatas_M009
1000 1000 133M	cetuc/Emigoncalvez_M020         1000 1000 174M	cetuc/DanielRientes_M040
1000 1000 153M	cetuc/Madel_F002                1000 1000 229M	cetuc/JoseIldo_M024
1000 1000 153M	cetuc/ClaudiaMoraes_F023        1000 1000 177M	cetuc/LeonaRodrigues_F022
1000 1000 129M	cetuc/JonatasPortugal_M031      1000 1000 142M	cetuc/JacksonBarbosa_M048
1000 1000 125M	cetuc/EduardoTardin_M022        1000 1000 152M	cetuc/Marcosvictor_M037
1000 1000 160M	cetuc/LuizCarlos_M029           1000 1000 140M	cetuc/Rodrigo_M043
1000 1000 145M	cetuc/LuisGustavo_M049          1000 1000 176M	cetuc/Aurea_F036
1000 1000 131M	cetuc/Paula_F026                1000 1000 163M	cetuc/Henrique_M030
1000 1000 175M	cetuc/Marcio_M011
```

</p>
</details>


### Constituição

> Corpus de voz da Constituição Federal. Em seguida, os arquivos foram 
> segmentados em arquivos menores, com aproximadamente 30 segundos de duração 
> cada, e por fim transcritos. Atualmente, o corpus é composto por um único 
> locutor do sexo masculino. Os arquivos totalizam aproximadamente 9 horas de 
> áudio. O ambiente de gravação utilizado é bastante controlado.


### Código de Defesa do Consumidor

TBD


### LaPS Benchmark

#### Descrição 1

> Corpus de voz utilizado para avaliação de desempenho de sistemas LVCSR.
> Atualmente composto por 700 frases, o corpus possui 35 locutores com 20 
> frases cada, sendo 25 homens e 10 mulheres, o que corresponde a 
> aproximadamente 54 minutos de áudio. Este corpus será expandido de forma a 
> ter 50 locutores com a mesma distribuição, totalizando 1.000 frases. Todas 
> as gravações foram realizadas em computadores utilizando microfones comuns. 
> A taxa de amostragem utilizada foi de 16.000 Hz e cada amostra foi 
> representada com 16 bits. O ambiente não foi controlado, existindo a 
> presença de ruído nas gravações, com isso busca-se caracterizar ambientes 
> onde software de reconhecimento de voz são utilizados.

#### Descrição 2

Seção 3.5 da 
[tese de doutorado de Nelson Neto (PPGEE, 2010)](https://ppgee.propesp.ufpa.br/ARQUIVOS/teses/TD05_2011_Nelson%20Cruz%20Sampaio%20Neto.pdf):

> Com o intuito de obter uma boa avaliação de desempenho e possibilitar a
> comparação de resultados com outros grupos de pesquisas, foi construı́do o 
> corpus de áudio LapsBenchmark.  Busca-se aqui criar um corpus de referência 
> com caracterı́sticas mais próximas da operação de um sistema ASR em ambientes
> ruidosos. Isso distingue o corpus LapsBenchmark do LapsStory, previamente
> apresentado.
>
> Para construção do corpus LapsBenchmark, foram utilizadas as sentenças 
> descritas em [80]. Atualmente, o corpus possui 35 locutores (homens e 
> mulheres) com 20 frases cada, que corresponde a 54 minutos de áudio. Todas 
> as gravações foram realizadas em computadores usando microfones comuns de 
> desktop. A taxa de amostragem utilizada foi de 16.000 Hz e cada amostra foi 
> representada com 16 bits. Como mencionado, o ambiente não foi controlado, 
> existindo a presença de ruı́do nas gravações. O corpus LapsBenchmark 
> encontra-se publicamente disponı́vel [1].
>
> É sabido que o corpus LapsBenchhmark precisa ter seu tamanho 
> consideravelmente aumentado para ser utilizado plenamente na realização de 
> experimentos considerados como LVCSR. Nesse trabalho, usa-se uma estratégia 
> que busca imitar a operação de um sistema LVCSR: o modelo de linguagem 
> possui mais de 60 mil palavras, e o decodificador precisa lidar com alta 
> perplexidade e descasamento acústico. Obviamente, tal estratégia permite 
> avaliar aspectos importantes mas possui limitações. Uma dessas limitações, 
> inerente à pouca quantidade de dados para teste, é a falta de robustez das 
> estimativas de taxa de erro, visto que o conjunto de teste (corpus 
> LapsBenchhmark) é relativamente reduzido.
>
> Diferentemente dos anteriores, os próximos dois corpora não foram 
> desenvolvidos nesta pesquisa. Contudo, os corpora de áudio Spoltech e 
> West Point serão descritos por terem sido usados nos experimentos, após 
> passarem por um processo de revisão manual.


### LaPS Story

:warning: private corpus :lock:

Seção 4.1.2 da 
[dissertação de mestrado de Rafael Oliveira (PPGCC, 2012)](https://ppgcc.propesp.ufpa.br/Disserta%C3%A7%C3%B5es_2012/Rafael%20Santana%20Oliveira_Disserta%C3%A7%C3%A3o.pdf):

> A LapsStory, desenvolvida em [Neto et al. 2010], é uma base de áudio para PB
> composto por arquivos extraídos de audiobooks, manualmente segmentados em
> arquivos menores com aproximadamente 30 segundos cada, amostrados em 16.000 
> Hz e quantizados em 16 bits. O corpus LapsStory é composto por 8 locutores 
> sendo 5 do sexo masculino e 3 do feminino totalizando 16 horas e 17 minutos 
> de áudio.  Devido ao fato de alguns dos audiobooks serem protegidos por 
> direitos autorais, apenas parte da LapsStory é distribuída publicamente 
> [FalaBrasil 2012].


### Spoltech

:warning: private corpus :lock:

Seção 3.6 da 
[tese de doutrado de Nelson Neto (PPGEE, 2011)](https://ppgee.propesp.ufpa.br/ARQUIVOS/teses/TD05_2011_Nelson%20Cruz%20Sampaio%20Neto.pdf):

> O corpus de áudio Spoltech [81] foi criado pela Universidade Federal do Rio
> Grande do Sul, Brasil, pela Universidade Federal de Caxias do Sul, Brasil, e
> pelo Oregon Graduate Institute, EUA. O corpus está incluı́do no catálogo do
> LDC (LDC2006S16).
> 
> O corpus Spoltech consiste de gravações via microfone de 477 locutores de
> múltiplos gêneros e várias regiões do Brasil com suas respectivas 
> transcrições fonéticas e ortográficas.  As gravações consistem tanto de 
> leituras de frases curtas quanto de respostas a perguntas (no intuito de 
> modelar a fala espontânea). No total, o corpus é composto por 8.080 arquivos 
> de voz digitalizada (extensão wav), 2.540 arquivos com transcrições no nı́vel 
> de palavra (arquivos de texto sem alinhamento temporal, com extensão txt) e 
> 5.479 arquivos com transcrições no nı́vel de fone (com alinhamento temporal e 
> extensão phn).
>
> O ambiente de gravação não foi controlado. Assim, algumas gravações foram 
> feitas em estúdio e outras em ambientes ruidosos (feiras, escolas, etc). 
> Os dados foram gravados a uma taxa de amostragem de 44.100 Hz (mono, 16-bit). 
> Embora útil, o corpus Spoltech possui vários problemas. Alguns arquivos de 
> áudio não possuem suas correspondentes transcrições ortográfica e fonética, 
> e vice-versa. Outro aspecto problemático é que suas transcrições pos- suem 
> muitos erros. Assim, uma trabalhosa e manual correção dos arquivos de áudio 
> e texto foi realizada [82].  No presente trabalho, apenas uma parte do corpus 
> foi usada, consistindo de 477 locutores e totalizando 4,3 horas de áudio. 
> Além disso, para utilização do mesmo de forma compatı́vel aos demais corpora 
> citados, os arquivos de áudio foram re-amostrados para 16.000 Hz.  


### West Point

:warning: private corpus :lock:

Seção 4.1.1 da 
[dissertação de mestrado de Rafael Oliveira (PPGCC, 2012)](https://ppgcc.propesp.ufpa.br/Disserta%C3%A7%C3%B5es_2012/Rafael%20Santana%20Oliveira_Disserta%C3%A7%C3%A3o.pdf):

> O West Point Brazilian Portuguese Speech é um corpus de áudio para PB criado
> pelo governo dos EUA com intuito de desenvolver modelos acústicos para 
> sistemas de reconhecimento de voz. O corpus é distribuído no catálogo da 
> LDC (LDC2008S04) e consiste de sentenças lidas por 60 mulheres e 68 homens, 
> nativos e não-nativos. As sentenças gravadas resumem-se a 296 frases e 
> expressões. O corpus West Point original possui algumas restrições, como 
> ausência de transcrições fonéticas e ortográficas, além da existência de 
> arquivos de áudio com falhas, como ruídos e fala não clara. Assim, apenas 
> um sub-conjunto da base, sugerido em [Santos et al. 2010] foi utilizado 
> para o treinamento dos modelos acústicos. No total, 7.920 arquivos com 
> locutores nativos foram usados, correspondendo a 8 horas de áudio, 
> amostrados em 16.000 Hz com 16 bits por amostra.


[![FalaBrasil](https://gitlab.com/falabrasil/avatars/-/raw/main/logo_fb_git_footer.png)](https://ufpafalabrasil.gitlab.io/ "Visite o site do Grupo FalaBrasil") [![UFPA](https://gitlab.com/falabrasil/avatars/-/raw/main/logo_ufpa_git_footer.png)](https://portal.ufpa.br/ "Visite o site da UFPA")


__Grupo FalaBrasil (2021)__     
__Universidade Federal do Pará__       
Cassio Batista - https://cassota.gitlab.io
