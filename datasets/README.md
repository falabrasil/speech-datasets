# DVC legacy

:warning: From July 2025 on, datasets are hosted on Hugging Face Hub:
https://huggingface.co/falabrasil/datasets

Datasets used to be stored on Google Drive using [DVC](https://dvc.org/).
Remote `public` is (hopefully) accessible by everyone that has a Google
account to authenticate on GDrive via DVC. Remote `private` on the other
hand is, well... private :slightly_smiling_face:.

To access the data you need to have 
[DVC installed with Google Drive support](https://dvc.org/doc/command-reference/remote/add#description):

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

# Download only a fraction of a dataset

To download only LapsBenchmark dataset:

```bash
$ dvc pull -r public datasets/lapsbm
```

To download only the test set of CETUC dataset (gambiarra):

```bash
$ dvc pull -r public datasets/cetuc/test.list
$ sed "s#^#$PWD/datasets/cetuc/#g" datasets/cetuc/test.list | xargs dvc pull -r public
$ sed "s#^#$PWD/datasets/cetuc/#g" datasets/cetuc/test.list | sed "s/\.wav/.txt/g" | xargs dvc pull -r public
```

To download the test set of all FalaBrasil's public datasets:

```bash
for ds in cetuc coddef constituicao lapsbm ; do
    dvc pull -r public datasets/$ds/test.list
    sed "s#^#$PWD/datasets/$ds/#g" datasets/$ds/test.list | xargs dvc pull -r public
    sed "s#^#$PWD/datasets/$ds/#g" datasets/$ds/test.list | sed "s/\.wav/.txt/g" | xargs dvc pull -r public
done
```
