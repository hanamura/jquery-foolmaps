# jquery-foolmaps

Display Google Maps without any thought.

## Usage

```html
<script src="https://code.jquery.com/jquery-2.1.1.js"></script>
<script src="[path to jquery-foolmaps]"></script>
```

### Static

```html
<img id="m" width="500" height="500" data-query="Tokyo Station">
```

```javascript
$('#m').foolmaps();
```

### Dynamic

```html
<script src="http://maps.googleapis.com/maps/api/js?key=[your api key here]&amp;sensor=false"></script>
```

```html
<div id="m" data-type="dynamic" data-query="Tokyo Station" style="height:500px; width:500px;"></div>
```

```javascript
$('#m').foolmaps();
```
