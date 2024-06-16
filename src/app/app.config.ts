import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideToastr } from 'ngx-toastr';
import { HTTP_INTERCEPTORS, provideHttpClient, withFetch, withInterceptors } from '@angular/common/http';
import { addTokenInterceptor } from './utils/add-token.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideHttpClient(withFetch(), withInterceptors([addTokenInterceptor])),
    provideAnimations(),
    provideToastr({timeOut:2000, preventDuplicates: true}),
    provideZoneChangeDetection({ eventCoalescing: true }), 
    provideRouter(routes)]
};
