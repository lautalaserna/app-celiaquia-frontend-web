import { MatPaginatorIntl } from '@angular/material/paginator';

const spanishRangeLabel = (page: number, pageSize: number, length: number) => {
  if (length === 0 || pageSize === 0) {
    return `0 de ${length}`;
  }
  const startIndex = page * pageSize;
  const endIndex = startIndex < length ? 
    Math.min(startIndex + pageSize, length) : 
    startIndex + pageSize;
  return `${startIndex + 1} - ${endIndex} de ${length}`;
}

export function getSpanishPaginatorIntl() {
  const paginatorIntl = new MatPaginatorIntl();
  paginatorIntl.itemsPerPageLabel = 'Items por página:';
  paginatorIntl.nextPageLabel = 'Siguiente página';
  paginatorIntl.previousPageLabel = 'Página anterior';
  paginatorIntl.firstPageLabel = 'Primera página';
  paginatorIntl.lastPageLabel = 'Última página';
  paginatorIntl.getRangeLabel = spanishRangeLabel;

  return paginatorIntl;
}
