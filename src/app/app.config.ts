import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideToastr } from 'ngx-toastr';
import { provideHttpClient, withFetch, withInterceptors } from '@angular/common/http';
import { addTokenInterceptor } from './utils/interceptors/add-token.interceptor';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { MatPaginatorIntl } from '@angular/material/paginator';
import { getSpanishPaginatorIntl } from './services/paginator-es';

export const appConfig: ApplicationConfig = {
  providers: [
    provideHttpClient(withFetch(), withInterceptors([addTokenInterceptor])),
    provideAnimations(),
    provideToastr({timeOut:2000, preventDuplicates: true}),
    provideZoneChangeDetection({ eventCoalescing: true }), 
    provideRouter(routes), provideAnimationsAsync(), provideAnimationsAsync(),
    { provide: MatPaginatorIntl, useValue: getSpanishPaginatorIntl() },
  ]
};
