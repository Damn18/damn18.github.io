---
layout: page
permalink: /skills/

title: skills
nav: true
nav_order: 4
---

{% assign skills = site.skills | sort: "order" %}

{% for skill in skills %}

## {{ skill.title }}

{% if skill.items %}
<ul>
{% for item in skill.items %}
<li>{{ item }}</li>
{% endfor %}
</ul>
{% endif %}

{% if skill.text %}
{{ skill.text }}
{% endif %}

---

{% endfor %}