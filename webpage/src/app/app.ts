import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  template: `
    <div class="h-full font-sans antialiased">
      <div class="flex h-screen bg-slate-50 dark:bg-slate-900 text-slate-900 dark:text-slate-100 transition-colors duration-300">
        
        <!-- TURBO DESKTOP SIDEBAR -->
        <aside class="hidden md:flex w-64 flex-col bg-white dark:bg-slate-800 border-r border-slate-200 dark:border-slate-700 shadow-sm transition-colors duration-300">
          <div class="p-6 flex items-center space-x-3">
            <img src="Logo.png" alt="Logo" class="w-8 h-8 object-contain">
            <span class="font-bold text-lg tracking-tight">TurboVets</span>
          </div>

          <nav class="flex-1 px-4 space-y-1 mt-4">
            <ng-container *ngTemplateOutlet="navLinks"></ng-container>
          </nav>

          <div class="p-4 border-t border-slate-200 dark:border-slate-700">
            <button (click)="toggleTheme()" 
                    class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-slate-600 dark:text-slate-300 bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 rounded-lg transition-colors">
              <span class="mr-2">{{ isDarkMode() ? '☀️' : '🌙' }}</span>
              {{ isDarkMode() ? 'Light Mode' : 'Dark Mode' }}
            </button>
          </div>
        </aside>


        <!-- MOBILE DRAWER -->
        
        <div *ngIf="isMobileMenuOpen()" 
             (click)="isMobileMenuOpen.set(false)"
             class="fixed inset-0 z-30 bg-black/50 backdrop-blur-sm md:hidden transition-opacity">
        </div>

        <aside class="fixed inset-y-0 left-0 z-40 w-64 bg-white dark:bg-slate-800 shadow-2xl transform transition-transform duration-300 md:hidden flex flex-col border-r border-slate-200 dark:border-slate-700"
               [class.translate-x-0]="isMobileMenuOpen()"
               [class.-translate-x-full]="!isMobileMenuOpen()">
            
            <div class="p-6 flex items-center justify-between border-b border-slate-100 dark:border-slate-700">
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-primary-500 rounded-lg flex items-center justify-center text-white font-bold shadow-lg">D</div>
                    <span class="font-bold text-lg tracking-tight">Dashboard</span>
                </div>
                <button (click)="isMobileMenuOpen.set(false)" class="text-slate-500 hover:text-slate-700 dark:text-slate-400">
                    <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
                </button>
            </div>

            <nav class="flex-1 px-4 space-y-1 mt-4">
                <ng-container *ngTemplateOutlet="navLinks"></ng-container>
            </nav>

            <div class="p-4 border-t border-slate-200 dark:border-slate-700">
                <button (click)="toggleTheme()" 
                        class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-slate-600 dark:text-slate-300 bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 rounded-lg transition-colors">
                  <span class="mr-2">{{ isDarkMode() ? '☀️' : '🌙' }}</span>
                  {{ isDarkMode() ? 'Light Mode' : 'Dark Mode' }}
                </button>
            </div>
        </aside>

        <main class="flex-1 overflow-hidden flex flex-col relative">
          <!-- Mobile Header -->
          <header class="md:hidden bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 p-4 flex justify-between items-center z-20 shadow-sm">
            <!-- Button -->
            <button (click)="toggleMobileMenu()" class="p-2 -ml-2 text-slate-600 dark:text-slate-300 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">
                <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
            </button>
            
            <span class="font-bold text-lg">Dashboard</span>
            
            <!-- Mobile Toggles -->
            <button (click)="toggleTheme()" class="p-2 rounded-md bg-slate-100 dark:bg-slate-700 text-sm">
              {{ isDarkMode() ? '☀️' : '🌙' }}
            </button>
          </header>

          <div class="flex-1 overflow-auto p-4 md:p-8">
            <router-outlet></router-outlet>
          </div>
        </main>
      </div>
    </div>

    <!-- Reusable Nav Links -->
    <ng-template #navLinks>
        <a routerLink="/dashboard" (click)="isMobileMenuOpen.set(false)" routerLinkActive="bg-primary-50 text-primary-600 dark:bg-slate-700 dark:text-primary-400" 
           class="flex items-center px-4 py-3 rounded-lg text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-700 transition-all group">
          <span class="mr-3">📊</span> Dashboard
        </a>
        
        <a routerLink="/tickets" (click)="isMobileMenuOpen.set(false)" routerLinkActive="bg-primary-50 text-primary-600 dark:bg-slate-700 dark:text-primary-400"
           class="flex items-center px-4 py-3 rounded-lg text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-700 transition-all group">
          <span class="mr-3">🎫</span> Tickets
        </a>

        <a routerLink="/logs" (click)="isMobileMenuOpen.set(false)" routerLinkActive="bg-primary-50 text-primary-600 dark:bg-slate-700 dark:text-primary-400"
           class="flex items-center px-4 py-3 rounded-lg text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-700 transition-all group">
          <span class="mr-3">📺</span> Live Logs
        </a>
    </ng-template>
  `
})
export class App {
  isDarkMode = signal(false);
  isMobileMenuOpen = signal(false);

  toggleTheme() {
    this.isDarkMode.update(v => !v);
    const html = document.documentElement;
    
    if (this.isDarkMode()) {
      html.classList.add('dark');
    } else {
      html.classList.remove('dark');
    }
  }

  toggleMobileMenu() {
    this.isMobileMenuOpen.update(v => !v);
  }
}