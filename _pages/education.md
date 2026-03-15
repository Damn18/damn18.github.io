---
layout: page
permalink: /education/

title: education
description: My academic background
nav: true
nav_order: 5
---

{% assign educations = site.education | sort: "order" %}

{% for edu in educations %}

## {{ edu.title }}

**{{ edu.school }}{% if edu.location %} — {{ edu.location }}{% endif %}**  
{{ edu.start }} – {{ edu.end }}

{% if edu.graduation %}
{{ edu.graduation }}
{% endif %}

{% if edu.description %}
{{ edu.description }}
{% endif %}

{% if edu.courses %}
### Courses
<ul>
{% for c in edu.courses %}
<li>{{ c }}</li>
{% endfor %}
</ul>
{% endif %}

{% if edu.minor %}
Minor: {{ edu.minor }}
{% endif %}

{% if edu.projects %}
### Activities
<ul>
{% for p in edu.projects %}
<li>{{ p }}</li>
{% endfor %}
</ul>
{% endif %}

---

{% endfor %}
