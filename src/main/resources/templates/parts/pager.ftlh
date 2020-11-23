<#macro pager url page>
    <div class="mt-3">
        <ul class="pagination">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Pages</a>
            </li>
            <#list 1..page.getTotalPages() as p>
                <#if (p-1) == page.getNumber()>
                    <li class="page-item active">
                        <a class="page-link" href="#" tabindex="#" aria-disabled="true">${p}</a>
                    </li>
                <#else>
                    <li class="page-item">
                        <a class="page-link" href="#" tabindex="${url}?page=${p-1}&size=${page.getSize()}" aria-disabled="true">${p}</a>
                    </li>
                </#if>
            </#list>
        </ul>

        <ul class="pagination">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Elements on page</a>
            </li>
            <#list [5, 10 ,25, 50] as c>
                <#if c == page.getSize()>
                    <li class="page-item active">
                        <a class="page-link" href="#" tabindex="#" aria-disabled="true">${c}</a>
                    </li>
                <#else>
                    <li class="page-item">
                        <a class="page-link" href="#" tabindex="${url}?page=${page.getNumber()}&size=${c}" aria-disabled="true">${c}</a>
                    </li>
                </#if>
            </#list>
        </ul>

    </div>
</#macro>