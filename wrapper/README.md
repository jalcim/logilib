```bash
python3 -m venv env
source env_name/bin/activate
pip install amaranth
```

- Si cette erreur suivante s'affiche, c'est qu'un des signaux concaténé n'a pas été initialisé :
```python
    raise TypeError("Object {!r} cannot be converted to an Amaranth value".format(obj))
TypeError: Object None cannot be converted to an Amaranth value
```
- Les signaux concaténé ne doivent pas etre enregistrer dans les ports lors de l'elaboration, (uniquement dans le am.Instance)
